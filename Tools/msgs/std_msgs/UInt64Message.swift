//
//  UInt64Message.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class UInt64Message: RBSMessage {
	public var data: uint64 = 0
    

    public override func mapping(map: Map) {
	    data <- map["data"]
    }
}
