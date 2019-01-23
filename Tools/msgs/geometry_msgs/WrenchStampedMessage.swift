//
//  WrenchStampedMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class WrenchStampedMessage: RBSMessage {
	public var header: HeaderMessage?
	public var wrench: WrenchMessage?
    
	public override init() {
		super.init()
		header = HeaderMessage()
	wrench = WrenchMessage()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    header <- map["header"]
		wrench <- map["wrench"]
    }
}
