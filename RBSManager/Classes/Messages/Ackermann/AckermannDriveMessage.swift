//
//  AckermannDriveMessage.swift
//  RBSManager
//
//  Created by Brandon Man on 25/7/2019.
//

import UIKit
import ObjectMapper

public class AckermannDriveMessage: RBSMessage{
    public var steering_angle: Float32?
    public var steering_angle_velocity: Float32?
    public var speed: Float32?
    public var acceleration: Float32?
    public var jerk: Float32?
    
    
    
    
    
    public override func mapping(map: Map) {
        steering_angle <- map["steering_angle"]
        steering_angle_velocity <- map["steering_angle_velocity"]
        speed <- map["speed"]
        acceleration <- map["acceleration"]
        jerk <- map["jerk"]
    }

}
