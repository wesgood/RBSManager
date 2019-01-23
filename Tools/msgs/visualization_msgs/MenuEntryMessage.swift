//
//  MenuEntryMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class MenuEntryMessage: RBSMessage {
	public var id: uint32 = 0
	public var parent_id: uint32 = 0
	public var title: string
	public var command: string
	public var FEEDBACK=0: uint8 = 0
	public var ROSRUN=1: uint8 = 0
	public var ROSLAUNCH=2: uint8 = 0
	public var command_type: uint8 = 0
    

    public override func mapping(map: Map) {
	    id <- map["id"]
		parent_id <- map["parent_id"]
		title <- map["title"]
		command <- map["command"]
		FEEDBACK=0 <- map["FEEDBACK=0"]
		ROSRUN=1 <- map["ROSRUN=1"]
		ROSLAUNCH=2 <- map["ROSLAUNCH=2"]
		command_type <- map["command_type"]
    }
}
