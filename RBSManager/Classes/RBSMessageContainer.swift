//
//  RBSMessageContainer.swift
//  Pods
//
//  Created by Wes Goodhoofd on 2018-01-06.
//

import Foundation
import ObjectMapper

public class RBSMessageContainer: NSObject, Mappable {
    var op = "publish"
    var msg: RBSMessage?
    var topic: String?
    var publisherId: String?

    required public init?(map: Map) {

    }

    init(message: RBSMessage, topic: String) {
        self.msg = message
        self.topic = topic
    }

    public func mapping(map: Map) {
        self.op <- map["op"]
        self.msg <- map["msg"]
        self.topic <- map["topic"]
        self.publisherId <- map["id"]
    }
}
