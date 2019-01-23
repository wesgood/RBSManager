//
//  TimeMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class TimeMessage: RBSMessage {
	public var data: time
    

    public override func mapping(map: Map) {
	    data <- map["data"]
    }
}
