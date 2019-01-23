//
//  AccelWithCovarianceStampedMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class AccelWithCovarianceStampedMessage: RBSMessage {
	public var header: HeaderMessage?
	public var accel: AccelWithCovarianceMessage?
    
	public override init() {
		super.init()
		header = HeaderMessage()
	accel = AccelWithCovarianceMessage()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    header <- map["header"]
		accel <- map["accel"]
    }
}
