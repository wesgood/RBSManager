//
//  JoyFeedbackMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class JoyFeedbackMessage: RBSMessage {
	public var TYPE_LED: uint8 = 0
	public var TYPE_RUMBLE: uint8 = 0
	public var TYPE_BUZZER: uint8 = 0
	public var type: uint8 = 0
	public var id: uint8 = 0
	public var intensity: float32 = 0
    

    public override func mapping(map: Map) {
	    TYPE_LED <- map["TYPE_LED"]
		TYPE_RUMBLE <- map["TYPE_RUMBLE"]
		TYPE_BUZZER <- map["TYPE_BUZZER"]
		type <- map["type"]
		id <- map["id"]
		intensity <- map["intensity"]
    }
}
