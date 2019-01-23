//
//  InteractiveMarkerInitMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class InteractiveMarkerInitMessage: RBSMessage {
	public var server_id: string
	public var seq_num: uint64 = 0
	public var markers: InteractiveMarkerMessage[]? = [InteractiveMarkerMessage[]]()
    
	public override init() {
		super.init()
		markers = InteractiveMarkerMessage[]()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    server_id <- map["server_id"]
		seq_num <- map["seq_num"]
		markers <- map["markers"]
    }
}
