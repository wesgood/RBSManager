//
//  JoyFeedbackArrayMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class JoyFeedbackArrayMessage: RBSMessage {
	public var array: JoyFeedbackMessage[]? = [JoyFeedbackMessage[]]()
    
	public override init() {
		super.init()
		array = JoyFeedbackMessage[]()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    array <- map["array"]
    }
}
