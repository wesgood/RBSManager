//
//  JointTrajectoryPointMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class JointTrajectoryPointMessage: RBSMessage {
	public var positions: float64[] = [float64[]]()
	public var velocities: float64[] = [float64[]]()
	public var accelerations: float64[] = [float64[]]()
	public var effort: float64[] = [float64[]]()
	public var time_from_start: duration
    

    public override func mapping(map: Map) {
	    positions <- map["positions"]
		velocities <- map["velocities"]
		accelerations <- map["accelerations"]
		effort <- map["effort"]
		time_from_start <- map["time_from_start"]
    }
}
