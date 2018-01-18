//
//  RBSManager.swift
//  Pods
//
//  Created by Wes Goodhoofd on 2018-01-06.
//

import UIKit
import Starscream
import ObjectMapper

private let _sharedManager = RBSManager()

public protocol RBSManagerDelegate {
    func manager(_ manager: RBSManager, didDisconnect error: Error?)
    func managerDidConnect(_ manager: RBSManager)
    func manager(_ manager: RBSManager, threwError error: Error)
}

public enum RBSManagerError: Int {
    case InvalidUrl = 500, SocketError, TimeoutError, JSONSerializerError, JSONDeserializerError
}

public class RBSManager: NSObject, WebSocketDelegate {
    var socket: WebSocket!
    public var delegate: RBSManagerDelegate?
    public var host: String?
    public var connected: Bool = false
    
    // socket handling
    var timeoutTimer: Timer?
    public var timeout: Double = 0
    
    // ROS handling
    var publishers: [RBSPublisher]
    var subscribers: [RBSSubscriber]
    var serviceCalls: [RBSServiceCall]
    
    public class func sharedManager() -> RBSManager {
        return _sharedManager
    }
    
    fileprivate override init() {
        publishers = [RBSPublisher]()
        subscribers = [RBSSubscriber]()
        serviceCalls = [RBSServiceCall]()
    }
    
    // MARK: ROSBridge objects
    
    /// create a subscriber and add to the array
    public func addSubscriber(topic: String, messageClass: RBSMessage.Type, response: @escaping ((_ message: RBSMessage) -> (Void))) -> RBSSubscriber {
        let subscriber = RBSSubscriber(manager: self, topic: topic, messageClass: messageClass, callback: response)
        subscribers.append(subscriber)
        return subscriber
    }
    
    /// create a publisher and add to the array
    public func addPublisher(topic: String, messageType: String, messageClass: RBSMessage.Type) -> RBSPublisher {
        let publisher = RBSPublisher(manager: self, topic: topic, messageType: messageType, messageClass: messageClass)
        publishers.append(publisher)
        return publisher
    }
    
    /// make a service call object
    public func makeServiceCall(service: String) -> RBSServiceCall {
        let serviceCall = RBSServiceCall(manager: self, service: service)
        serviceCalls.append(serviceCall)
        return serviceCall
    }
    
    /// create a service call to set a parameter
    public func setParam(name: String, value: Any) -> RBSServiceCall {
        let serviceCall = makeServiceCall(service: "/rosapi/set_param")
        serviceCall.arrayArgument = [name, value]
        return serviceCall
    }
    
    /// create a service call to get a parameter
    public func getParam(name: String) -> RBSServiceCall {
        let serviceCall = makeServiceCall(service: "/rosapi/get_param")
        serviceCall.arrayArgument = [name]
        return serviceCall
    }
    
    /// batch multiple service calls together
    public func sendMultipleServiceCalls(_ calls: [RBSServiceCall]) {
        for call in calls {
            call.send(nil)
        }
    }
    
    
    func advertisePublishers() {
        for publisher in publishers {
            publisher.advertise()
        }
    }
    
    func attachSubscribers() {
        for subscriber in subscribers {
            subscriber.subscribe()
        }
    }
    
    func removePublishers() {
        for publisher in publishers {
            publisher.unadvertise()
        }
    }
    
    func removeSubscribers() {
        for subscriber in subscribers {
            subscriber.unsubscribe()
        }
    }
    
    // MARK: Socket handling
    public func connect(address: String) {
        // validate the address
        var addressString = address
        if !addressString.starts(with: "ws://") {
            addressString = "ws://"+addressString
        }
        host = addressString
        
        if let url = URL(string: host!) {
            // create the timeout timer
            if timeout > 0 {
                timeoutTimer = Timer.scheduledTimer(withTimeInterval: timeout, repeats: false, block: { (timer) in
                    // send the delegate method
                    self.connected = false
                    self.socket = nil
                    let error = self.createError("Connection timed out", code: RBSManagerError.TimeoutError.rawValue)
                    self.delegate?.manager(self, threwError: error)
                })
            }
            socket = WebSocket(url: url)
            socket.callbackQueue = DispatchQueue(label: "rbsmanager_socket")
            socket.delegate = self
            socket.connect()
        } else {
            let error = createError("Requested websocket URL is invalid", code: RBSManagerError.InvalidUrl.rawValue)
            self.delegate?.manager(self, threwError: error)
        }
    }
    
    public func disconnect() {
        removePublishers()
        removeSubscribers()
        socket?.disconnect()
    }
    
    /// create an error object
    func createError(_ detail: String, code: Int) -> Error {
        var details = [String: String]()
        details[NSLocalizedDescriptionKey] =  detail
        return NSError(domain: "RBSManagerError", code: code, userInfo: details) as Error
    }
    
    /// Convert an object to JSON and send through the socket
    func sendData(object: Mappable) {
        if let jsonString = object.toJSONString(prettyPrint: false) {
            socket?.write(string: jsonString)
        }
    }
    
    /// Convert a dictionary to JSON and send through the socket
    func sendData(dictionary: [String : Any]) {
        // ignore the Mapper for now
        if let jsonData = try? JSONSerialization.data(
            withJSONObject: dictionary,
            options: []) {
            if let jsonString = String(data: jsonData, encoding: .ascii) {
                socket?.write(string: jsonString)
            }
        } else {
            let error = createError("unable to generate JSON", code: RBSManagerError.JSONSerializerError.rawValue)
            self.delegate?.manager(self, threwError: error)
        }
    }
    
    /// Send a JSON string through the socket
    func sendData(JSON: String) {
        socket?.write(string: JSON)
    }
    
    func postSubscriberData(_ data: [String : Any]) {
        // map the provided dictionary into the correct models
        let subscriberId = data["id"] as? String
        let topic = data["topic"] as? String
        
        for subscriber in subscribers {
            if ((subscriber.subscriberId != nil && subscriber.subscriberId == subscriberId) || subscriber.subscriberId == nil) && subscriber.topic == topic {
                // use the provided message type to generate a new instance
                let messageType = subscriber.messageClass
                if let messageData = data["msg"] as? [String : Any] {
                    let map = Map.init(mappingType: .fromJSON, JSON: messageData)
                    if let message = messageType.init(map: map) {
                        DispatchQueue.main.async {
                            subscriber.callback(message)
                        }
                    } else {
                        let error = createError("unable to generate object of type \(messageType.description)", code: RBSManagerError.JSONDeserializerError.rawValue)
                        DispatchQueue.main.async {
                            self.delegate?.manager(self, threwError: error)
                        }
                    }
                }
            }
        }
    }
    
    func postServiceCallData(_ data: [String : Any]) {
        // map the provided dictionary into the correct models
        let serviceId = data["id"] as? String
        let service = data["service"] as? String
        
        for serviceCall in serviceCalls {
            if ((serviceCall.serviceId != nil && serviceCall.serviceId == serviceId) || serviceCall.serviceId == nil) && serviceCall.service == service {
                DispatchQueue.main.async {
                    serviceCall.responseCallback?(data["values"] as! [String : Any])
                }
            }
        }
    }
    
    // MARK: WebSocket delegate methods
    public func websocketDidConnect(socket: WebSocketClient) {
        self.connected = true
        self.timeoutTimer?.invalidate()
        self.advertisePublishers()
        self.attachSubscribers()
        DispatchQueue.main.async {
            self.delegate?.managerDidConnect(self)
        }
    }
    
    public func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        self.connected = false
        DispatchQueue.main.async {
            self.delegate?.manager(self, didDisconnect: error)
        }
        self.socket = nil
    }
    
    public func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        // deserialize first to know what to do
        var dictionary: [String : Any]?
        if let data = text.data(using: .utf8) {
            do {
                dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        
        // process the dictionary
        if let op = dictionary?["op"] as? String {
            if op == "publish" {
                // handle the subscription response
                postSubscriberData(dictionary!)
            } else if op == "service_response" {
                // handle the service response
                postServiceCallData(dictionary!)
            }
        }
    }
    
    public func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        
    }
}
