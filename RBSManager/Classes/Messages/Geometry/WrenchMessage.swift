//
//  WrenchMessage.swift
//  Pods
//
//  Created by Wes Goodhoofd on 2018-01-11.
//

import UIKit
import ObjectMapper

public class WrenchMessage: RBSMessage {
    public var force: Vector3Message?
    public var torque: Vector3Message?
    
    public override init() {
        super.init()
        force = Vector3Message()
        torque = Vector3Message()
    }
    
    public required init?(map: Map) {
        super.init(map: map)
    }
    
    override public func mapping(map: Map) {
        force <- map["force"]
        torque <- map["torque"]
    }
}
