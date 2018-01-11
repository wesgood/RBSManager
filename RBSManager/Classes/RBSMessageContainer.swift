//
//  RBSMessageContainer.swift
//  Pods
//
//  Created by Wes Goodhoofd on 2018-01-06.
//

import UIKit
import ObjectMapper

public class RBSMessageContainer: NSObject, Mappable {
    var op = "publish"
    var msg: RBSMessage?
    var topic: String?
    var publisherId: String?
    
    required public init?(map: Map) {
    
    }
    
    init(_ msg: RBSMessage, topic t: String) {
        self.msg = msg
        self.topic = t
    }
    
    public func mapping(map: Map) {
        self.op <- map["op"]
        self.msg <- map["msg"]
        self.topic <- map["topic"]
        self.publisherId <- map["id"]
    }
}
