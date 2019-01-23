//
//  RegionOfInterestMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class RegionOfInterestMessage: RBSMessage {
	public var x_offset: uint32 = 0
	public var (0: #
	public var y_offset: uint32 = 0
	public var (0: #
	public var height: uint32 = 0
	public var width: uint32 = 0
	public var do_rectify: bool = false
    

    public override func mapping(map: Map) {
	    x_offset <- map["x_offset"]
		(0 <- map["(0"]
		y_offset <- map["y_offset"]
		(0 <- map["(0"]
		height <- map["height"]
		width <- map["width"]
		do_rectify <- map["do_rectify"]
    }
}
