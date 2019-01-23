//
//  MultiDOFJointTrajectoryMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class MultiDOFJointTrajectoryMessage: RBSMessage {
	public var header: HeaderMessage?
	public var joint_names: string[] = [string[]]()
	public var points: MultiDOFJointTrajectoryPointMessage[]? = [MultiDOFJointTrajectoryPointMessage[]]()
    
	public override init() {
		super.init()
		header = HeaderMessage()
	points = MultiDOFJointTrajectoryPointMessage[]()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    header <- map["header"]
		joint_names <- map["joint_names"]
		points <- map["points"]
    }
}
