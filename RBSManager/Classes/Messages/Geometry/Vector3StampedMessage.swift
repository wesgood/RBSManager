//
//  Vector3StampedMessage.swift
//  RBSManager
//
//  Created by Wes Goodhoofd on 2019-07-20.
//

import UIKit
import ObjectMapper

public class Vector3StampedMessage: RBSMessage {
    public var header: HeaderMessage?
    public var vector: Vector3Message?
    
    public override init() {
        super.init()
        header = HeaderMessage()
        vector = Vector3Message()
    }
    
    public required init?(map: Map) {
        super.init(map: map)
    }
    
    override public func mapping(map: Map) {
        header <- map["header"]
        vector <- map["vector"]
    }
}
