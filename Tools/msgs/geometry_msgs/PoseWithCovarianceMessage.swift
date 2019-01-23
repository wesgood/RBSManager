//
//  PoseWithCovarianceMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class PoseWithCovarianceMessage: RBSMessage {
	public var pose: PoseMessage?
	public var covariance: float64[36] = [float64[36]]()
    
	public override init() {
		super.init()
		pose = PoseMessage()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    pose <- map["pose"]
		covariance <- map["covariance"]
    }
}
