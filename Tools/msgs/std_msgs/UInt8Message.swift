//
//  UInt8Message.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class UInt8Message: RBSMessage {
	public var data: uint8 = 0
    

    public override func mapping(map: Map) {
	    data <- map["data"]
    }
}
