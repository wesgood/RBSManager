//
//  PolygonStampedMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class PolygonStampedMessage: RBSMessage {
	public var header: HeaderMessage?
	public var polygon: PolygonMessage?
    
	public override init() {
		super.init()
		header = HeaderMessage()
	polygon = PolygonMessage()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    header <- map["header"]
		polygon <- map["polygon"]
    }
}
