//
//  PoseWithCovarianceStampedMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class PoseWithCovarianceStampedMessage: RBSMessage {
	public var header: HeaderMessage?
	public var pose: PoseWithCovarianceMessage?
    
	public override init() {
		super.init()
		header = HeaderMessage()
	pose = PoseWithCovarianceMessage()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    header <- map["header"]
		pose <- map["pose"]
    }
}
