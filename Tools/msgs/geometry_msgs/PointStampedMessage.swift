//
//  PointStampedMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class PointStampedMessage: RBSMessage {
	public var header: HeaderMessage?
	public var point: PointMessage? = 0
    
	public override init() {
		super.init()
		header = HeaderMessage()
	point = PointMessage()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    header <- map["header"]
		point <- map["point"]
    }
}
