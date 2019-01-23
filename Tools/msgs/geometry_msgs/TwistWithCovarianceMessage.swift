//
//  TwistWithCovarianceMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class TwistWithCovarianceMessage: RBSMessage {
	public var twist: TwistMessage?
	public var covariance: float64[36] = [float64[36]]()
    
	public override init() {
		super.init()
		twist = TwistMessage()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    twist <- map["twist"]
		covariance <- map["covariance"]
    }
}
