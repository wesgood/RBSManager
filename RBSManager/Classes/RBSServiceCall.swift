//
//  RBSServiceCall.swift
//  Pods
//
//  Created by Wes Goodhoofd on 2018-01-06.
//

import UIKit
import ObjectMapper

public class RBSServiceCall: NSObject {
    var manager: RBSManager
    public var service: String
    public var dataArgument: [String : String]?
    public var messageArgument: Mappable?
    public var arrayArgument: [Any]?
    var responseCallback: ((_ data: [String : Any]) -> (Void))?
    
    // ROS specific options
    public var fragmentSize: Int?
    public var compression: String?
    public var serviceId: String?
    
    init(manager m: RBSManager, service s: String) {
        self.manager = m
        self.service = s
    }
    
    /// send a service call and optionally handle the response
    public func send(_ response: ((_ data: [String : Any]) -> (Void))?) {
        self.responseCallback = response
        
        // build the dictionary to send to ROS
        var data = [String : Any]()
        data["op"] = "call_service"
        data["service"] = self.service
        
        // add options to configure the subscriber
        if let argumentOption = dataArgument {
            data["args"] = argumentOption
        } else if let argumentOption = messageArgument {
            let jsonObject = argumentOption.toJSON()
            data["args"] = jsonObject
        } else if let argumentOption = arrayArgument {
            data["args"] = argumentOption
        }
        
        if let serviceIdOption = serviceId {
            data["id"] = serviceIdOption
        }
        
        if let fragmentSizeOption = fragmentSize {
            data["fragment_size"] = String(describing: fragmentSizeOption)
        }
        
        if let compressionOption = compression {
            data["compression"] = compressionOption
        }
        
        // pass the data to the manager
        self.manager.sendData(dictionary: data)
    }
}
