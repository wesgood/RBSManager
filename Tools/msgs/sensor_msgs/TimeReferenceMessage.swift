//
//  TimeReferenceMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class TimeReferenceMessage: RBSMessage {
	public var header: HeaderMessage?
	public var frame_id: #
	public var time_ref: time
	public var source: string
    
	public override init() {
		super.init()
		header = HeaderMessage()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    header <- map["header"]
		frame_id <- map["frame_id"]
		time_ref <- map["time_ref"]
		source <- map["source"]
    }
}
