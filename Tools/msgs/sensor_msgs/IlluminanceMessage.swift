//
//  IlluminanceMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class IlluminanceMessage: RBSMessage {
	public var Single: #
	public var measured: #
	public var The: #
	public var the: #
	public var Photometric: #
	public var intensity: #
	public var All: #
	public var not: #
	public var This: #
	public var Luminous: #
	public var Luminance: #
	public var Irradiance: #
	public var header: HeaderMessage?
	public var frame_id: #
	public var illuminance: float64 = 0
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
		measured <- map["measured"]
		The <- map["The"]
		the <- map["the"]
		Photometric <- map["Photometric"]
		intensity <- map["intensity"]
		All <- map["All"]
		not <- map["not"]
		This <- map["This"]
		Luminous <- map["Luminous"]
		Luminance <- map["Luminance"]
		Irradiance <- map["Irradiance"]
		header <- map["header"]
		frame_id <- map["frame_id"]
		illuminance <- map["illuminance"]
		variance <- map["variance"]
    }
}
