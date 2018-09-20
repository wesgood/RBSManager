//
//  ByteMessage.swift
//
//  Created by wesgoodhoofd on 2018-09-19.
//

import UIKit
import ObjectMapper

public class ByteMessage: RBSMessage {
	public var data: UInt8 = 0
    

    public override func mapping(map: Map) {
	    data <- map["data"]
    }
}
