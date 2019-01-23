//
//  PoseStampedMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class PoseStampedMessage: RBSMessage {
	public var header: HeaderMessage?
	public var pose: PoseMessage?
    
	public override init() {
		super.init()
		header = HeaderMessage()
	pose = PoseMessage()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    header <- map["header"]
		pose <- map["pose"]
    }
}
