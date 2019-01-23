//
//  ImageMarkerMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class ImageMarkerMessage: RBSMessage {
	public var CIRCLE=0: uint8 = 0
	public var LINE_STRIP=1: uint8 = 0
	public var LINE_LIST=2: uint8 = 0
	public var POLYGON=3: uint8 = 0
	public var POINTS=4: uint8 = 0
	public var ADD=0: uint8 = 0
	public var REMOVE=1: uint8 = 0
	public var header: HeaderMessage?
	public var ns: string
	public var id: int32 = 0
	public var type: int32 = 0
	public var action: int32 = 0
	public var position: PointMessage? = 0
	public var scale: float32 = 0
	public var outline_color: ColorRGBAMessage?
	public var filled: uint8 = 0
	public var fill_color: ColorRGBAMessage?
	public var lifetime: duration
	public var points: PointMessage[]? = [PointMessage[]]()
	public var outline_colors: ColorRGBAMessage[]? = [ColorRGBAMessage[]]()
    
	public override init() {
		super.init()
		header = HeaderMessage()
	position = PointMessage()
	outline_color = ColorRGBAMessage()
	fill_color = ColorRGBAMessage()
	points = PointMessage[]()
	outline_colors = ColorRGBAMessage[]()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    CIRCLE=0 <- map["CIRCLE=0"]
		LINE_STRIP=1 <- map["LINE_STRIP=1"]
		LINE_LIST=2 <- map["LINE_LIST=2"]
		POLYGON=3 <- map["POLYGON=3"]
		POINTS=4 <- map["POINTS=4"]
		ADD=0 <- map["ADD=0"]
		REMOVE=1 <- map["REMOVE=1"]
		header <- map["header"]
		ns <- map["ns"]
		id <- map["id"]
		type <- map["type"]
		action <- map["action"]
		position <- map["position"]
		scale <- map["scale"]
		outline_color <- map["outline_color"]
		filled <- map["filled"]
		fill_color <- map["fill_color"]
		lifetime <- map["lifetime"]
		points <- map["points"]
		outline_colors <- map["outline_colors"]
    }
}
