//
//  PoseMessage.swift
//  RBSManager
//
//  Created by Wes Goodhoofd on 2018-01-10.
//

import UIKit
import ObjectMapper

public class PoseMessage: RBSMessage {
    public var x: Float?
    public var y: Float?
    public var theta: Float?
    
    public var linearVelocity: Float?
    public var angularVelocity: Float?
    
    override public func mapping(map: Map) {
        x <- map["x"]
        y <- map["y"]
        theta <- map["theta"]
        
        linearVelocity <- map["linear_velocity"]
        angularVelocity <- map["angular_velocity"]
    }
    
}
