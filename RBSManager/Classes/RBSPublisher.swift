//
//  RBSPublisher.swift
//  Pods
//
//  Created by Wes Goodhoofd on 2018-01-06.
//

import UIKit
import ObjectMapper

public class RBSPublisher: NSObject {
    var manager: RBSManager
    var messageClass: Mappable.Type
    var messageType: String
    var topic: String
    
    // configuration options
    var active: Bool = false
    var tag: String?
    
    // ROS specific options
    var publisherId: String?
    
    init(manager m: RBSManager, topic t: String, messageType mt: String, messageClass mc: Mappable.Type) {
        self.manager = m
        self.topic = t
        self.messageClass = mc
        self.messageType = mt
    }
    
    /// add the message to a container and send to manager for transmit
    func publish(_ message: Mappable) {
        let container = RBSMessageContainer(message, topic: topic)
        
        if let publisherIdOption = publisherId {
            container.publisherId = publisherIdOption
        }
        
        self.manager.sendData(object: container)
    }
    
    /// advertise this publisher on ROS
    func advertise() {
        self.active = true
        
        var data = [
            "op" : "advertise",
            "topic" : self.topic,
            "type" : self.messageType,
        ]
        
        if let publisherIdOption = publisherId {
            data["id"] = publisherIdOption
        }
        
        self.manager.sendData(dictionary: data)
    }
    
    /// remove this publisher from ROS to stop sending messages
    func unadvertise() {
        self.active = false
        
        var data = [
            "op" : "unadvertise",
            "topic" : self.topic
        ]
        
        if let publisherIdOption = publisherId {
            data["id"] = publisherIdOption
        }
        
        self.manager.sendData(dictionary: data)
    }
}
