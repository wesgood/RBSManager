//
//  FluidPressureMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class FluidPressureMessage: RBSMessage {
	public var Single: #
	public var pressure: #
	public var atmospheric: #
	public var This: #
	public var header: HeaderMessage?
	public var frame_id: #
	public var fluid_pressure: float64 = 0
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
		atmospheric <- map["atmospheric"]
		This <- map["This"]
		header <- map["header"]
		frame_id <- map["frame_id"]
		fluid_pressure <- map["fluid_pressure"]
		variance <- map["variance"]
    }
}
