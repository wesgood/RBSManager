//
//  AccelWithCovarianceMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class AccelWithCovarianceMessage: RBSMessage {
	public var accel: AccelMessage?
	public var covariance: float64[36] = [float64[36]]()
    
	public override init() {
		super.init()
		accel = AccelMessage()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    accel <- map["accel"]
		covariance <- map["covariance"]
    }
}
