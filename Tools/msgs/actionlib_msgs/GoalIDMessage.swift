//
//  GoalIDMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class GoalIDMessage: RBSMessage {
	public var stamp: time
	public var id: string
    

    public override func mapping(map: Map) {
	    stamp <- map["stamp"]
		id <- map["id"]
    }
}
