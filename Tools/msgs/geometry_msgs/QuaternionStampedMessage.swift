//
//  QuaternionStampedMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class QuaternionStampedMessage: RBSMessage {
	public var header: HeaderMessage?
	public var quaternion: QuaternionMessage?
    
	public override init() {
		super.init()
		header = HeaderMessage()
	quaternion = QuaternionMessage()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    header <- map["header"]
		quaternion <- map["quaternion"]
    }
}
