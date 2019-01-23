//
//  Float32Message.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class Float32Message: RBSMessage {
	public var data: float32 = 0
    

    public override func mapping(map: Map) {
	    data <- map["data"]
    }
}
