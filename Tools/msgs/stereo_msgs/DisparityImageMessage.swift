//
//  DisparityImageMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class DisparityImageMessage: RBSMessage {
	public var header: HeaderMessage?
	public var image: ImageMessage?
	public var f: float32 = 0
	public var T: float32 = 0
	public var valid_window: RegionOfInterestMessage? = 0
	public var min_disparity: float32 = 0
	public var max_disparity: float32 = 0
	public var delta_d: float32 = 0
    
	public override init() {
		super.init()
		header = HeaderMessage()
	image = ImageMessage()
	valid_window = RegionOfInterestMessage()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    header <- map["header"]
		image <- map["image"]
		f <- map["f"]
		T <- map["T"]
		valid_window <- map["valid_window"]
		min_disparity <- map["min_disparity"]
		max_disparity <- map["max_disparity"]
		delta_d <- map["delta_d"]
    }
}
