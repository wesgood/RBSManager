//
//  ImageHeaderMessage.swift
//
//  Created by helming on 2018-10-24.
//

import UIKit
import ObjectMapper
import RBSManager

public class Header: RBSMessage {
	public var seq: Int = 0
	public var stamp: TimeStamp?
	public var frame_id: String?
    
	public override init() {
		super.init()
		stamp = TimeStamp()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    seq <- map["seq"]
		stamp <- map["stamp"]
		frame_id <- map["frame_id"]
    }
}
