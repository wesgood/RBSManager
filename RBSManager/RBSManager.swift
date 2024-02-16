//
//  RBSManager.swift
//  Pods
//
//  Created by Wes Goodhoofd on 2018-01-06.
//

import Foundation
import Starscream
import ObjectMapper

private let _sharedManager = RBSManager()

public protocol RBSManagerDelegate: AnyObject {
    func manager(_ manager: RBSManager, didDisconnect error: Error?)
    func managerDidConnect(_ manager: RBSManager)
    func manager(_ manager: RBSManager, threwError error: Error)
}

public enum RBSManagerError: Int {
    case invalidUrl = 500
    case socketError
    case timeoutError
    case jsonSerializerError
    case jsonDeserializerError
}

public class RBSManager: NSObject, WebSocketDelegate {
    var socket: WebSocket!
    public var delegate: RBSManagerDelegate?
    public var host: String?
    public var connected: Bool = false

    // socket handling
    var timeoutTimer: Timer?
    public var timeout: Double = 10.0

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
    public func addSubscriber(topic: String, messageClass: RBSMessage.Type,
                              response: @escaping ((_ message: RBSMessage) -> Void)) -> RBSSubscriber {
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
        for publisher in publishers where publisher.active {
            publisher.advertise()
        }
    }

    func attachSubscribers() {
        for subscriber in subscribers where subscriber.active {
            subscriber.subscribe()
        }
    }

    func removePublishers() {
        for publisher in publishers where publisher.connected {
            publisher.unadvertise()
        }
    }

    func removeSubscribers() {
        for subscriber in subscribers where subscriber.connected {
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
                timeoutTimer = Timer.scheduledTimer(withTimeInterval: timeout, repeats: false, block: { _ in
                    // send the delegate method
                    self.connected = false
                    self.socket = nil
                    let error = self.createError("connection timed out", code: RBSManagerError.timeoutError.rawValue)
                    self.delegate?.manager(self, threwError: error)
                })
            }

            var request = URLRequest(url: url)
            request.timeoutInterval = TimeInterval(timeout)

            self.socket = WebSocket(request: request)
            self.socket.callbackQueue = DispatchQueue(label: "rbsmanager_socket")
            self.socket.delegate = self
            self.socket.connect()
        } else {
            let error = createError("requested websocket URL is invalid", code: RBSManagerError.invalidUrl.rawValue)
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
        if !connected {
            return
        }

        if let jsonString = object.toJSONString(prettyPrint: false) {
            socket?.write(string: jsonString)
        }
    }

    /// Convert a dictionary to JSON and send through the socket
    func sendData(dictionary: [String: Any]) {
        if !connected {
            return
        }

        // ignore the Mapper for now
        if let jsonData = try? JSONSerialization.data(
            withJSONObject: dictionary,
            options: []) {
            if let jsonString = String(data: jsonData, encoding: .ascii) {
                socket?.write(string: jsonString)
            }
        } else {
            let error = createError("unable to generate JSON", code: RBSManagerError.jsonSerializerError.rawValue)
            self.delegate?.manager(self, threwError: error)
        }
    }

    /// Send a JSON string through the socket
    func sendData(JSON: String) {
        socket?.write(string: JSON)
    }

    func postSubscriberData(_ response: RBSResponse) {
        // map the provided dictionary into the correct models
        for subscriber in subscribers where subscriber.topic == response.topic {
            // use the provided message type to generate a new instance
            let messageType = subscriber.messageClass
            if let messageData = response.message {
                let map = Map.init(mappingType: .fromJSON, JSON: messageData)
                if let message = messageType.init(map: map) {
                    DispatchQueue.main.async {
                        subscriber.callback(message)
                    }
                } else {
                    let error =
                        createError("cannot create object of type \(String(describing: messageType.description))",
                        code: RBSManagerError.jsonDeserializerError.rawValue)
                    DispatchQueue.main.async {
                        self.delegate?.manager(self, threwError: error)
                    }
                }
            }
        }
    }

    func postServiceCallData(_ response: RBSResponse) {
        // map the provided dictionary into the correct models
        var toRemove = [Int]()

        for (index, serviceCall) in serviceCalls.enumerated() {
            if ((serviceCall.serviceId != nil && serviceCall.serviceId == response.responseId) ||
                serviceCall.serviceId == nil) && serviceCall.service == response.service {
                DispatchQueue.main.async {
                    serviceCall.responseCallback?(response)
                }
                toRemove.append(index)
                break
            }
        }

        // remove calls that have completed
        for index in toRemove {
            self.serviceCalls.remove(at: index)
        }
    }

    // MARK: WebSocket delegate methods

    public func websocketDidConnect(socket: WebSocketClient) {
        self.timeoutTimer?.invalidate()
        self.connected = true
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
        // map to the response object
        if let response = Mapper<RBSResponse>().map(JSONString: text) {
            if let operation = response.operation {
                switch operation {
                case .publish:
                    postSubscriberData(response)
                case .serviceResponse:
                    postServiceCallData(response)
                }
            }
        }
    }

    public func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
    }

    // MARK: - Accessors

    /// Retrieve a single subscriber matching the topic and unique ID
    ///
    /// - Parameters:
    ///   - topic: the topic string
    ///   - id: the optional subscriber ID
    /// - Returns: nil or matching subscriber object
    public func getSubscriber(topic: String, subscriberId: String? = nil) -> RBSSubscriber? {
        let filtered = subscribers.filter({ return topic == $0.topic && $0.subscriberId == subscriberId })
        return filtered.first
    }

    /// Retrieve a single publisher matching the topic and unique ID
    ///
    /// - Parameters:
    ///   - topic: the topic string
    ///   - id: the optional publisher ID
    /// - Returns: nil or matching publisher object
    public func getPublisher(topic: String, publisherId: String? = nil) -> RBSPublisher? {
        let filtered = publishers.filter({ return topic == $0.topic && $0.publisherId == publisherId })
        return filtered.first
    }

    /// Retrieve a single service call matching the service and unique ID
    ///
    /// - Parameters:
    ///   - service: the topic string
    ///   - id: the optional publisher ID
    /// - Returns: nil or matching service call
    public func getServiceCall(service: String, serviceId: String? = nil) -> RBSServiceCall? {
        let filtered = serviceCalls.filter({ return service == $0.service && $0.serviceId == serviceId })
        return filtered.first
    }

    // MARK: - Utility methods
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map { _ in letters.randomElement()! })
    }
}
