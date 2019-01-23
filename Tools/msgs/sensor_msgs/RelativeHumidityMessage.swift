//
//  RelativeHumidityMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class RelativeHumidityMessage: RBSMessage {
	public var Single: #
	public var pressure: #
	public var header: HeaderMessage?
	public var frame_id: #
	public var relative_humidity: float64 = 0
	public var from: #
	public var 0.0: #
	public var 1.0: #
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
		pressure <- map["pressure"]
		header <- map["header"]
		frame_id <- map["frame_id"]
		relative_humidity <- map["relative_humidity"]
		from <- map["from"]
		0.0 <- map["0.0"]
		1.0 <- map["1.0"]
		variance <- map["variance"]
    }
}
