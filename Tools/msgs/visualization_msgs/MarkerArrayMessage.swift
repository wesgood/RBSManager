//
//  MarkerArrayMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class MarkerArrayMessage: RBSMessage {
	public var markers: MarkerMessage[]? = [MarkerMessage[]]()
    
	public override init() {
		super.init()
		markers = MarkerMessage[]()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    markers <- map["markers"]
    }
}
