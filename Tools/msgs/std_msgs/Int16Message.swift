//
//  Int16Message.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class Int16Message: RBSMessage {
	public var data: int16 = 0
    

    public override func mapping(map: Map) {
	    data <- map["data"]
    }
}
