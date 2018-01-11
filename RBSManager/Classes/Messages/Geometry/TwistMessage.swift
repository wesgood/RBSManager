//
//  TwistMessage.swift
//  ObjectMapper
//
//  Created by Wes Goodhoofd on 2018-01-10.
//

import UIKit
import ObjectMapper

public class TwistMessage: RBSMessage {
    public var linear: Vector3Message?
    public var angular: Vector3Message?
    
    public override init() {
        super.init()
        linear = Vector3Message()
        angular = Vector3Message()
    }
    
    public required init?(map: Map) {
        super.init(map: map)
    }
    
    override public func mapping(map: Map) {
        linear <- map["linear"]
        angular <- map["angular"]
    }
}
