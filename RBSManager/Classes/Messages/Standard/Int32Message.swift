//
//  Int32Message.swift
//
//  Created by wesgoodhoofd on 2018-09-19.
//

import UIKit
import ObjectMapper

public class Int32Message: RBSMessage {
	public var data: Int32 = 0
    

    public override func mapping(map: Map) {
	    data <- map["data"]
    }
}
