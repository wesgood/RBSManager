//
//  InteractiveMarkerFeedbackMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class InteractiveMarkerFeedbackMessage: RBSMessage {
	public var header: HeaderMessage?
	public var client_id: string
	public var marker_name: string
	public var control_name: string
	public var KEEP_ALIVE: uint8 = 0
	public var POSE_UPDATE: uint8 = 0
	public var MENU_SELECT: uint8 = 0
	public var BUTTON_CLICK: uint8 = 0
	public var MOUSE_DOWN: uint8 = 0
	public var MOUSE_UP: uint8 = 0
	public var event_type: uint8 = 0
	public var pose: PoseMessage?
	public var menu_entry_id: uint32 = 0
	public var mouse_point: PointMessage? = 0
	public var mouse_point_valid: bool = false
    
	public override init() {
		super.init()
		header = HeaderMessage()
	pose = PoseMessage()
	mouse_point = PointMessage()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    header <- map["header"]
		client_id <- map["client_id"]
		marker_name <- map["marker_name"]
		control_name <- map["control_name"]
		KEEP_ALIVE <- map["KEEP_ALIVE"]
		POSE_UPDATE <- map["POSE_UPDATE"]
		MENU_SELECT <- map["MENU_SELECT"]
		BUTTON_CLICK <- map["BUTTON_CLICK"]
		MOUSE_DOWN <- map["MOUSE_DOWN"]
		MOUSE_UP <- map["MOUSE_UP"]
		event_type <- map["event_type"]
		pose <- map["pose"]
		menu_entry_id <- map["menu_entry_id"]
		mouse_point <- map["mouse_point"]
		mouse_point_valid <- map["mouse_point_valid"]
    }
}
