//
//  TwistWithCovarianceStampedMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class TwistWithCovarianceStampedMessage: RBSMessage {
	public var header: HeaderMessage?
	public var twist: TwistWithCovarianceMessage?
    
	public override init() {
		super.init()
		header = HeaderMessage()
	twist = TwistWithCovarianceMessage()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    header <- map["header"]
		twist <- map["twist"]
    }
}
