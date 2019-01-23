//
//  UInt32Message.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class UInt32Message: RBSMessage {
	public var data: uint32 = 0
    

    public override func mapping(map: Map) {
	    data <- map["data"]
    }
}
