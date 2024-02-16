//
//  RBSPublisher.swift
//  Pods
//
//  Created by Wes Goodhoofd on 2018-01-06.
//

import Foundation
import ObjectMapper

public class RBSPublisher: NSObject {
    var manager: RBSManager
    public var messageClass: RBSMessage.Type
    public var messageType: String
    public var topic: String

    // configuration options
    public var active: Bool = true
    public var connected: Bool = false
    public var tag: String?

    // ROS specific options
    public var publisherId: String?

    init(manager: RBSManager, topic: String, messageType: String, messageClass: RBSMessage.Type) {
        self.manager = manager
        self.topic = topic
        self.messageClass = messageClass
        self.messageType = messageType
    }

    /// add the message to a container and send to manager for transmit
    public func publish(_ message: RBSMessage) {
        let container = RBSMessageContainer(message: message, topic: topic)

        if let publisherIdOption = publisherId {
            container.publisherId = publisherIdOption
        }

        self.manager.sendData(object: container)
    }

    /// advertise this publisher on ROS
    public func advertise() {
        self.connected = true

        var data = [
            "op": "advertise",
            "topic": self.topic,
            "type": self.messageType
        ]

        // force publisher ID assignment - this allows multiple publishers
//        if publisherId == nil {
//            publisherId = manager.randomString(length: 8)
//        }
        data["id"] = publisherId

        self.manager.sendData(dictionary: data)
    }

    /// remove this publisher from ROS to stop sending messages
    public func unadvertise() {
        self.connected = false

        var data = [
            "op": "unadvertise",
            "topic": self.topic
        ]

        if let publisherIdOption = publisherId {
            data["id"] = publisherIdOption
        }

        self.manager.sendData(dictionary: data)
    }
}
