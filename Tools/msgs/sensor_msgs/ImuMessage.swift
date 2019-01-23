//
//  ImuMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class ImuMessage: RBSMessage {
	public var header: HeaderMessage?
	public var orientation: QuaternionMessage?
	public var orientation_covariance: float64[9] = [float64[9]]()
	public var angular_velocity: Vector3Message?
	public var angular_velocity_covariance: float64[9] = [float64[9]]()
	public var linear_acceleration: Vector3Message?
	public var linear_acceleration_covariance: float64[9] = [float64[9]]()
    
	public override init() {
		super.init()
		header = HeaderMessage()
	orientation = QuaternionMessage()
	angular_velocity = Vector3Message()
	linear_acceleration = Vector3Message()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    header <- map["header"]
		orientation <- map["orientation"]
		orientation_covariance <- map["orientation_covariance"]
		angular_velocity <- map["angular_velocity"]
		angular_velocity_covariance <- map["angular_velocity_covariance"]
		linear_acceleration <- map["linear_acceleration"]
		linear_acceleration_covariance <- map["linear_acceleration_covariance"]
    }
}
