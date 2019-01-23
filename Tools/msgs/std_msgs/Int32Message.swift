//
//  Int32Message.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class Int32Message: RBSMessage {
	public var data: int32 = 0
    

    public override func mapping(map: Map) {
	    data <- map["data"]
    }
}
