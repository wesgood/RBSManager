//
//  JointTrajectoryMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class JointTrajectoryMessage: RBSMessage {
	public var header: HeaderMessage?
	public var joint_names: string[] = [string[]]()
	public var points: JointTrajectoryPointMessage[]? = [JointTrajectoryPointMessage[]]()
    
	public override init() {
		super.init()
		header = HeaderMessage()
	points = JointTrajectoryPointMessage[]()
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
