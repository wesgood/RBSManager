//
//  ByteMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class ByteMessage: RBSMessage {
	public var data: byte
    

    public override func mapping(map: Map) {
	    data <- map["data"]
    }
}
