//
//  GoalStatusMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class GoalStatusMessage: RBSMessage {
	public var goal_id: GoalIDMessage?
	public var status: uint8 = 0
	public var PENDING: uint8 = 0
	public var ACTIVE: uint8 = 0
	public var PREEMPTED: uint8 = 0
	public var and: #
	public var SUCCEEDED: uint8 = 0
	public var ABORTED: uint8 = 0
	public var to: #
	public var REJECTED: uint8 = 0
	public var because: #
	public var PREEMPTING: uint8 = 0
	public var and: #
	public var RECALLING: uint8 = 0
	public var but: #
	public var RECALLED: uint8 = 0
	public var and: #
	public var LOST: uint8 = 0
	public var sent: #
	public var text: string
    
	public override init() {
		super.init()
		goal_id = GoalIDMessage()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    goal_id <- map["goal_id"]
		status <- map["status"]
		PENDING <- map["PENDING"]
		ACTIVE <- map["ACTIVE"]
		PREEMPTED <- map["PREEMPTED"]
		and <- map["and"]
		SUCCEEDED <- map["SUCCEEDED"]
		ABORTED <- map["ABORTED"]
		to <- map["to"]
		REJECTED <- map["REJECTED"]
		because <- map["because"]
		PREEMPTING <- map["PREEMPTING"]
		and <- map["and"]
		RECALLING <- map["RECALLING"]
		but <- map["but"]
		RECALLED <- map["RECALLED"]
		and <- map["and"]
		LOST <- map["LOST"]
		sent <- map["sent"]
		text <- map["text"]
    }
}
