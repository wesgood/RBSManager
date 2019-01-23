//
//  MarkerMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class MarkerMessage: RBSMessage {
	public var ARROW=0: uint8 = 0
	public var CUBE=1: uint8 = 0
	public var SPHERE=2: uint8 = 0
	public var CYLINDER=3: uint8 = 0
	public var LINE_STRIP=4: uint8 = 0
	public var LINE_LIST=5: uint8 = 0
	public var CUBE_LIST=6: uint8 = 0
	public var SPHERE_LIST=7: uint8 = 0
	public var POINTS=8: uint8 = 0
	public var TEXT_VIEW_FACING=9: uint8 = 0
	public var MESH_RESOURCE=10: uint8 = 0
	public var TRIANGLE_LIST=11: uint8 = 0
	public var ADD=0: uint8 = 0
	public var MODIFY=0: uint8 = 0
	public var DELETE=2: uint8 = 0
	public var DELETEALL=3: uint8 = 0
	public var header: HeaderMessage?
	public var ns: string
	public var id: int32 = 0
	public var type: int32 = 0
	public var action: int32 = 0
	public var pose: PoseMessage?
	public var scale: Vector3Message?
	public var color: ColorRGBAMessage?
	public var lifetime: duration
	public var frame_locked: bool = false
	public var points: PointMessage[]? = [PointMessage[]]()
	public var colors: ColorRGBAMessage[]? = [ColorRGBAMessage[]]()
	public var text: string
	public var mesh_resource: string
	public var mesh_use_embedded_materials: bool = false
    
	public override init() {
		super.init()
		header = HeaderMessage()
	pose = PoseMessage()
	scale = Vector3Message()
	color = ColorRGBAMessage()
	points = PointMessage[]()
	colors = ColorRGBAMessage[]()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    ARROW=0 <- map["ARROW=0"]
		CUBE=1 <- map["CUBE=1"]
		SPHERE=2 <- map["SPHERE=2"]
		CYLINDER=3 <- map["CYLINDER=3"]
		LINE_STRIP=4 <- map["LINE_STRIP=4"]
		LINE_LIST=5 <- map["LINE_LIST=5"]
		CUBE_LIST=6 <- map["CUBE_LIST=6"]
		SPHERE_LIST=7 <- map["SPHERE_LIST=7"]
		POINTS=8 <- map["POINTS=8"]
		TEXT_VIEW_FACING=9 <- map["TEXT_VIEW_FACING=9"]
		MESH_RESOURCE=10 <- map["MESH_RESOURCE=10"]
		TRIANGLE_LIST=11 <- map["TRIANGLE_LIST=11"]
		ADD=0 <- map["ADD=0"]
		MODIFY=0 <- map["MODIFY=0"]
		DELETE=2 <- map["DELETE=2"]
		DELETEALL=3 <- map["DELETEALL=3"]
		header <- map["header"]
		ns <- map["ns"]
		id <- map["id"]
		type <- map["type"]
		action <- map["action"]
		pose <- map["pose"]
		scale <- map["scale"]
		color <- map["color"]
		lifetime <- map["lifetime"]
		frame_locked <- map["frame_locked"]
		points <- map["points"]
		colors <- map["colors"]
		text <- map["text"]
		mesh_resource <- map["mesh_resource"]
		mesh_use_embedded_materials <- map["mesh_use_embedded_materials"]
    }
}
