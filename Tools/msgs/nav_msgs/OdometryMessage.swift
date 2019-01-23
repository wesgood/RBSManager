//
//  OdometryMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class OdometryMessage: RBSMessage {
	public var header: HeaderMessage?
	public var child_frame_id: string
	public var pose: PoseWithCovarianceMessage?
	public var twist: TwistWithCovarianceMessage?
    
	public override init() {
		super.init()
		header = HeaderMessage()
	pose = PoseWithCovarianceMessage()
	twist = TwistWithCovarianceMessage()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    header <- map["header"]
		child_frame_id <- map["child_frame_id"]
		pose <- map["pose"]
		twist <- map["twist"]
    }
}
