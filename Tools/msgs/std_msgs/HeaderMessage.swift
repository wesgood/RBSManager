//
//  HeaderMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class HeaderMessage: RBSMessage {
	public var seq: uint32 = 0
	public var stamp: time
	public var frame_id: string
    

    public override func mapping(map: Map) {
	    seq <- map["seq"]
		stamp <- map["stamp"]
		frame_id <- map["frame_id"]
    }
}
