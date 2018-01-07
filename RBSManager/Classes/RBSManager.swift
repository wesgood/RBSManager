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

protocol RBSManagerDelegate {
    func manager(_ manager: RBSManager, didDisconnect: Error?)
    func managerDidTimeout(_ manager: RBSManager)
    func managerDidConnect(_ manager: RBSManager)
}

class RBSManager: NSObject, WebSocketDelegate {
    var socket: WebSocket!
    var delegate: RBSManagerDelegate?
    var host: String?
    var connected: Bool = false
    
    // socket handling
    var timeoutTimer: Timer?
    var timeout: Double = 0
    
    // ROS handling
    var publishers: [RBSPublisher]
    var subscribers: [RBSSubscriber]
    var serviceCalls: [RBSServiceCall]
    
    class func sharedManager() -> RBSManager {
        return _sharedManager
    }
    
    fileprivate override init() {
        publishers = [RBSPublisher]()
        subscribers = [RBSSubscriber]()
        serviceCalls = [RBSServiceCall]()
    }
    
    // MARK: ROSBridge objects
    
    /// create a subscriber and add to the array
    func addSubscriber(topic: String, messageClass: Mappable, response: @escaping ((_ message: Mappable) -> (Void))) -> RBSSubscriber {
        let subscriber = RBSSubscriber(manager: self, topic: topic, messageClass: messageClass, callback: response)
        subscribers.append(subscriber)
        return subscriber
    }
    
    /// create a publisher and add to the array
    func addPublisher(topic: String, messageType: String, messageClass: Mappable) -> RBSPublisher {
        let publisher = RBSPublisher(manager: self, topic: topic, messageType: messageType, messageClass: messageClass)
        publishers.append(publisher)
        return publisher
    }
    
    /// make a service call object
    func makeServiceCall(service: String) -> RBSServiceCall {
        let serviceCall = RBSServiceCall(manager: self, service: service)
        serviceCalls.append(serviceCall)
        return serviceCall
    }
    
    /// create a service call to set a parameter
    func setParam(name: String, value: Any) -> RBSServiceCall {
        let serviceCall = makeServiceCall(service: "/rosapi/set_param")
        serviceCall.arrayArgument = [name, value]
        return serviceCall
    }
    
    /// create a service call to get a parameter
    func getParam(name: String) -> RBSServiceCall {
        let serviceCall = makeServiceCall(service: "/rosapi/get_param")
        return serviceCall
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
    func connect(address: String) throws {
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
                    self.delegate?.managerDidTimeout(self)
                })
            }
            socket = WebSocket(url: url)
            socket.delegate = self
            socket.connect()
        } else {
            throw "Requested websocket URL is invalid"
        }
    }
    
    func disconnect() {
        removePublishers()
        removeSubscribers()
        socket?.disconnect()
    }
    
    /// Convert an object to JSON and send through the socket
    func sendData(object: Mappable) {
        if let jsonString = object.toJSONString(prettyPrint: false) {
            socket?.write(string: jsonString)
        }
    }
    
    /// Convert a dictionary to JSON and send through the socket
    func sendData(dictionary: [String : Any]) {
        // TODO
    }
    
    /// Send a JSON string through the socket
    func sendData(JSON: String) {
        socket?.write(string: JSON)
    }
    
    func postSubscriberData(_ data: [String : Any]) {
        
    }
    
    func postServiceCallData(_ data: [String : Any]) {
        
    }
    
    // MARK: WebSocket delegate methods
    func websocketDidConnect(socket: WebSocketClient) {
        self.connected = true
        self.timeoutTimer?.invalidate()
        self.advertisePublishers()
        self.attachSubscribers()
        self.delegate?.managerDidConnect(self)
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        self.connected = false
        self.delegate?.manager(self, didDisconnect: error)
        self.socket = nil
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        let response = Mapper<[String : Any]>().map(JSONString: text) {
            if let op = response["op"] as? String {
                if op == "publish" {
                    // handle the subscription response
                    postSubscriberData(response)
                } else if op == "service_response" {
                    // handle the service response
                    postServiceCallData(response)
                }
            }
        }
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        
    }
}

// MARK: Extensions
extension String: LocalizedError {
    public var errorDescription: String? { return self }
}
