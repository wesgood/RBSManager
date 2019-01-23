//
//  RangeMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class RangeMessage: RBSMessage {
	public var header: HeaderMessage?
	public var returned: #
	public var ULTRASOUND=0: uint8 = 0
	public var INFRARED=1: uint8 = 0
	public var radiation_type: uint8 = 0
	public var (sound,: #
	public var field_of_view: float32 = 0
	public var valid: #
	public var the: #
	public var been: #
	public var field_of_view/2: #
	public var 0: #
	public var min_range: float32 = 0
	public var max_range: float32 = 0
	public var Fixed: #
	public var range: float32 = 0
	public var (Note:: #
	public var should: #
	public var Fixed: #
	public var -Inf: #
	public var (Detection: #
	public var +Inf: #
	public var (Object: #
    
	public override init() {
		super.init()
		header = HeaderMessage()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    header <- map["header"]
		returned <- map["returned"]
		ULTRASOUND=0 <- map["ULTRASOUND=0"]
		INFRARED=1 <- map["INFRARED=1"]
		radiation_type <- map["radiation_type"]
		(sound, <- map["(sound,"]
		field_of_view <- map["field_of_view"]
		valid <- map["valid"]
		the <- map["the"]
		been <- map["been"]
		field_of_view/2 <- map["field_of_view/2"]
		0 <- map["0"]
		min_range <- map["min_range"]
		max_range <- map["max_range"]
		Fixed <- map["Fixed"]
		range <- map["range"]
		(Note: <- map["(Note:"]
		should <- map["should"]
		Fixed <- map["Fixed"]
		-Inf <- map["-Inf"]
		(Detection <- map["(Detection"]
		+Inf <- map["+Inf"]
		(Object <- map["(Object"]
    }
}
