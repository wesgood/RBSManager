//
//  PathMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class PathMessage: RBSMessage {
	public var header: HeaderMessage?
	public var poses: PoseStampedMessage[]? = [PoseStampedMessage[]]()
    
	public override init() {
		super.init()
		header = HeaderMessage()
	poses = PoseStampedMessage[]()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    header <- map["header"]
		poses <- map["poses"]
    }
}
