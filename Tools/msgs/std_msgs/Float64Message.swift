//
//  Float64Message.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class Float64Message: RBSMessage {
	public var data: float64 = 0
    

    public override func mapping(map: Map) {
	    data <- map["data"]
    }
}
