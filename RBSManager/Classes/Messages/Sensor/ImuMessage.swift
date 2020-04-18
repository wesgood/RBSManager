//
//  OrientationMessage.swift
//  RBSManager
//
//  Created by Wes Goodhoofd on 2020-04-01.
//

import UIKit
import ObjectMapper

public class OrientationMessage: RBSMessage {
    public var header: HeaderMessage?
    public var orientation: QuaternionMessage?
    public var angularVelocity: Vector3Message?
    public var linearAcceleration: Vector3Message?
    
    public var orientationCovariance: [Float64]?
    public var angularVelocityCovariance: [Float64]?
    public var linearAccelerationCovariance: [Float64]?
    
    public override init() {
        super.init()
        
        header = HeaderMessage()
        orientation = QuaternionMessage()
        angularVelocity = Vector3Message()
        linearAcceleration = Vector3Message()
        
        orientationCovariance = [Float64]()
        angularVelocityCovariance = [Float64]()
        linearAccelerationCovariance = [Float64]()
    }
    
    public required init?(map: Map) {
        super.init(map: map)
    }
    
    public override func mapping(map: Map) {
        header <- map["header"]
        orientation <- map["orientation"]
        angularVelocity <- map["angular_velocity"]
        linearAcceleration <- map["linear_acceleration"]
        
        orientationCovariance <- map["orientation_covariance"]
        angularVelocityCovariance <- map["angular_velocity_covariance"]
        linearAccelerationCovariance <- map["linear_acceleration_covariance"]
    }
}
