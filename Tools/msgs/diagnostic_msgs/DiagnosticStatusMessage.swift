//
//  DiagnosticStatusMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class DiagnosticStatusMessage: RBSMessage {
	public var OK=0: byte
	public var WARN=1: byte
	public var ERROR=2: byte
	public var STALE=3: byte
	public var level: byte
	public var name: string
	public var message: string
	public var hardware_id: string
	public var values: KeyValueMessage[]? = [KeyValueMessage[]]()
    
	public override init() {
		super.init()
		values = KeyValueMessage[]()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    OK=0 <- map["OK=0"]
		WARN=1 <- map["WARN=1"]
		ERROR=2 <- map["ERROR=2"]
		STALE=3 <- map["STALE=3"]
		level <- map["level"]
		name <- map["name"]
		message <- map["message"]
		hardware_id <- map["hardware_id"]
		values <- map["values"]
    }
}
