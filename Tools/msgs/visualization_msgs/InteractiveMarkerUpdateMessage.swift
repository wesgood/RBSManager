//
//  InteractiveMarkerUpdateMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class InteractiveMarkerUpdateMessage: RBSMessage {
	public var server_id: string
	public var seq_num: uint64 = 0
	public var KEEP_ALIVE: uint8 = 0
	public var UPDATE: uint8 = 0
	public var type: uint8 = 0
	public var markers: InteractiveMarkerMessage[]? = [InteractiveMarkerMessage[]]()
	public var poses: InteractiveMarkerPoseMessage[]? = [InteractiveMarkerPoseMessage[]]()
	public var erases: string[] = [string[]]()
    
	public override init() {
		super.init()
		markers = InteractiveMarkerMessage[]()
	poses = InteractiveMarkerPoseMessage[]()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    server_id <- map["server_id"]
		seq_num <- map["seq_num"]
		KEEP_ALIVE <- map["KEEP_ALIVE"]
		UPDATE <- map["UPDATE"]
		type <- map["type"]
		markers <- map["markers"]
		poses <- map["poses"]
		erases <- map["erases"]
    }
}
