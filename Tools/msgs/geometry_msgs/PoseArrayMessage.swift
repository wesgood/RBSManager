//
//  PoseArrayMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class PoseArrayMessage: RBSMessage {
	public var header: HeaderMessage?
	public var poses: PoseMessage[]? = [PoseMessage[]]()
    
	public override init() {
		super.init()
		header = HeaderMessage()
	poses = PoseMessage[]()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    header <- map["header"]
		poses <- map["poses"]
    }
}
