//
//  RBSSubscriber.swift
//  Pods
//
//  Created by Wes Goodhoofd on 2018-01-06.
//

import Foundation
import ObjectMapper

public class RBSSubscriber: NSObject {
    var manager: RBSManager
    public var messageClass: RBSMessage.Type
    public var topic: String
    var callback: ((_ message: RBSMessage) -> Void)

    // configuration options
    public var active: Bool = true
    public var connected: Bool = false
    public var tag: String?

    // ROS specific options
    public var messageType: String?
    public var subscriberId: String?
    public var throttleRate: Int?
    public var queueLength: Int?
    public var fragmentSize: Int?
    public var compression: String?

    init(manager: RBSManager, topic: String, messageClass: RBSMessage.Type,
         callback: @escaping (_ message: RBSMessage) -> Void) {
        self.manager = manager
        self.topic = topic
        self.messageClass = messageClass
        self.callback = callback
    }

    /// Tell ROSBridge to begin passing messages when they are received
    public func subscribe() {
        self.connected = true

        // build the dictionary to send to ROS
        var data = [String: Any]()
        data["op"] = "subscribe"
        data["topic"] = self.topic

        // add options to configure the subscriber
        if let messageTypeOption = messageType {
            data["type"] = messageTypeOption
        }

        // force subscriber ID assignment - this allows multiple subscribers
//        if subscriberId == nil {
//            subscriberId = manager.randomString(length: 8)
//        }
        data["id"] = subscriberId

        if let throttleRateOption = throttleRate {
            data["throttle_rate"] = throttleRateOption
        }

        if let queueLengthOption = queueLength {
            data["queue_length"] = queueLengthOption
        }

        if let fragmentSizeOption = fragmentSize {
            data["fragment_size"] = fragmentSizeOption
        }

        if let compressionOption = compression {
            data["compression"] = compressionOption
        }

        // pass the data to the manager
        self.manager.sendData(dictionary: data)
    }

    /// Tell ROS to stop sending messages
    public func unsubscribe() {
        self.connected = false

        var data = [
            "op": "unsubscribe",
            "topic": self.topic
        ]

        if let subscriberIdOption = subscriberId {
            data["id"] = subscriberIdOption
        }

        self.manager.sendData(dictionary: data)
    }
}
