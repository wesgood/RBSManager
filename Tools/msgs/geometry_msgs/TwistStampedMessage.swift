//
//  TwistStampedMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class TwistStampedMessage: RBSMessage {
	public var header: HeaderMessage?
	public var twist: TwistMessage?
    
	public override init() {
		super.init()
		header = HeaderMessage()
	twist = TwistMessage()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    header <- map["header"]
		twist <- map["twist"]
    }
}
