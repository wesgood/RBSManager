//
//  AckermannDriveMessage.swift
//  RBSManager
//
//  Created by Brandon Man on 25/7/2019.
//

import Foundation
import ObjectMapper

public class AckermannDriveMessage: RBSMessage {
    public var steeringAngle: Float32?
    public var steeringAngleVelocity: Float32?
    public var speed: Float32?
    public var acceleration: Float32?
    public var jerk: Float32?

    public override func mapping(map: Map) {
        steeringAngle <- map["steering_angle"]
        steeringAngleVelocity <- map["steering_angle_velocity"]
        speed <- map["speed"]
        acceleration <- map["acceleration"]
        jerk <- map["jerk"]
    }
}
