//
//  InteractiveMarkerControlMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class InteractiveMarkerControlMessage: RBSMessage {
	public var name: string
	public var orientation: QuaternionMessage?
	public var INHERIT: uint8 = 0
	public var FIXED: uint8 = 0
	public var VIEW_FACING: uint8 = 0
	public var orientation_mode: uint8 = 0
	public var NONE: uint8 = 0
	public var MENU: uint8 = 0
	public var BUTTON: uint8 = 0
	public var MOVE_AXIS: uint8 = 0
	public var MOVE_PLANE: uint8 = 0
	public var ROTATE_AXIS: uint8 = 0
	public var MOVE_ROTATE: uint8 = 0
	public var MOVE_3D: uint8 = 0
	public var ROTATE_3D: uint8 = 0
	public var MOVE_ROTATE_3D: uint8 = 0
	public var interaction_mode: uint8 = 0
	public var always_visible: bool = false
	public var markers: MarkerMessage[]? = [MarkerMessage[]]()
	public var independent_marker_orientation: bool = false
	public var description: string
    
	public override init() {
		super.init()
		orientation = QuaternionMessage()
	markers = MarkerMessage[]()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    name <- map["name"]
		orientation <- map["orientation"]
		INHERIT <- map["INHERIT"]
		FIXED <- map["FIXED"]
		VIEW_FACING <- map["VIEW_FACING"]
		orientation_mode <- map["orientation_mode"]
		NONE <- map["NONE"]
		MENU <- map["MENU"]
		BUTTON <- map["BUTTON"]
		MOVE_AXIS <- map["MOVE_AXIS"]
		MOVE_PLANE <- map["MOVE_PLANE"]
		ROTATE_AXIS <- map["ROTATE_AXIS"]
		MOVE_ROTATE <- map["MOVE_ROTATE"]
		MOVE_3D <- map["MOVE_3D"]
		ROTATE_3D <- map["ROTATE_3D"]
		MOVE_ROTATE_3D <- map["MOVE_ROTATE_3D"]
		interaction_mode <- map["interaction_mode"]
		always_visible <- map["always_visible"]
		markers <- map["markers"]
		independent_marker_orientation <- map["independent_marker_orientation"]
		description <- map["description"]
    }
}
