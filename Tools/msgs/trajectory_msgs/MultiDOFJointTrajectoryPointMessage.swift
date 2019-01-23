//
//  MultiDOFJointTrajectoryPointMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class MultiDOFJointTrajectoryPointMessage: RBSMessage {
	public var transforms: TransformMessage[]? = [TransformMessage[]]()
	public var velocities: TwistMessage[]? = [TwistMessage[]]()
	public var accelerations: TwistMessage[]? = [TwistMessage[]]()
	public var time_from_start: duration
    
	public override init() {
		super.init()
		transforms = TransformMessage[]()
	velocities = TwistMessage[]()
	accelerations = TwistMessage[]()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    transforms <- map["transforms"]
		velocities <- map["velocities"]
		accelerations <- map["accelerations"]
		time_from_start <- map["time_from_start"]
    }
}
