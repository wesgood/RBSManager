//
//  Pose2DMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class Pose2DMessage: RBSMessage {
	public var x: float64 = 0
	public var y: float64 = 0
	public var theta: float64 = 0
    

    public override func mapping(map: Map) {
	    x <- map["x"]
		y <- map["y"]
		theta <- map["theta"]
    }
}
