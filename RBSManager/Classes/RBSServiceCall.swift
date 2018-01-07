//
//  RBSServiceCall.swift
//  Pods
//
//  Created by Wes Goodhoofd on 2018-01-06.
//

import UIKit
import ObjectMapper

class RBSServiceCall: NSObject {
    var manager: RBSManager
    var service: String
    var dataArgument: [String : String]?
    var messageArgument: Mappable?
    var arrayArgument: [Any]?
    var responseCallback: ((_ data: [String : String]) -> (Void))?
    
    // ROS specific options
    var fragmentSize: Int?
    var compression: String?
    var serviceId: String?
    
    init(manager m: RBSManager, service s: String) {
        self.manager = m
        self.service = s
    }
    
    /// send a service call and optionally handle the response
    func send(_ response: ((_ data: [String : String]) -> (Void))?) {
        self.responseCallback = response
        
        // build the dictionary to send to ROS
        var data = [String : Any]()
        data["op"] = "call_service"
        data["service"] = self.service
        
        // add options to configure the subscriber
        if let argumentOption = dataArgument {
            data["args"] = argumentOption
        } else if let argumentOption = messageArgument {
            data["args"] = argumentOption
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
