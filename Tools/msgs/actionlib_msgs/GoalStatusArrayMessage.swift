//
//  GoalStatusArrayMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class GoalStatusArrayMessage: RBSMessage {
	public var header: HeaderMessage?
	public var status_list: GoalStatusMessage[]? = [GoalStatusMessage[]]()
    
	public override init() {
		super.init()
		header = HeaderMessage()
	status_list = GoalStatusMessage[]()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    header <- map["header"]
		status_list <- map["status_list"]
    }
}
