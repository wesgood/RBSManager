//
//  PoseMessage.swift
//  RBSManager
//
//  Created by Wes Goodhoofd on 2018-01-10.
//

import UIKit
import ObjectMapper

class PoseMessage: RBSMessage {
    var x: Float?
    var y: Float?
    var theta: Float?
    
    var linearVelocity: Float?
    var angularVelocity: Float?
    
    override func mapping(map: Map) {
        x <- map["x"]
        y <- map["y"]
        z <- map["z"]
        
        linearVelocity <- map["linear_velocity"]
        angularVelocity <- map["angular_velocity"]
    }
    
}
