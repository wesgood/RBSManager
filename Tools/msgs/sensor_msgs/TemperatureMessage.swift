//
//  TemperatureMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class TemperatureMessage: RBSMessage {
	public var Single: #
	public var header: HeaderMessage?
	public var frame_id: #
	public var temperature: float64 = 0
	public var variance: float64 = 0
    
	public override init() {
		super.init()
		header = HeaderMessage()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    Single <- map["Single"]
		header <- map["header"]
		frame_id <- map["frame_id"]
		temperature <- map["temperature"]
		variance <- map["variance"]
    }
}
