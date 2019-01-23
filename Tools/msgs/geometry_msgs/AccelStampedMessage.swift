//
//  AccelStampedMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class AccelStampedMessage: RBSMessage {
	public var header: HeaderMessage?
	public var accel: AccelMessage?
    
	public override init() {
		super.init()
		header = HeaderMessage()
	accel = AccelMessage()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    header <- map["header"]
		accel <- map["accel"]
    }
}
