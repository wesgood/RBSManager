//
//  RBSMessageContainer.swift
//  Pods
//
//  Created by Wes Goodhoofd on 2018-01-06.
//

import Foundation
import ObjectMapper

public class RBSMessageContainer: NSObject, Mappable {
    var operation = "publish"
    var message: RBSMessage?
    var topic: String?
    var publisherId: String?

    required public init?(map: Map) {

    }

    init(message: RBSMessage, topic: String) {
        self.message = message
        self.topic = topic
    }

    public func mapping(map: Map) {
        self.operation <- map["op"]
        self.message <- map["msg"]
        self.topic <- map["topic"]
        self.publisherId <- map["id"]
    }
}
