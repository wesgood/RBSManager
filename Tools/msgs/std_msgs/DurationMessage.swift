//
//  DurationMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class DurationMessage: RBSMessage {
	public var data: duration
    

    public override func mapping(map: Map) {
	    data <- map["data"]
    }
}
