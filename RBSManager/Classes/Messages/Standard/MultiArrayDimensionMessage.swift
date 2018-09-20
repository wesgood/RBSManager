//
//  MultiArrayDimensionMessage.swift
//
//  Created by wesgoodhoofd on 2018-09-19.
//

import UIKit
import ObjectMapper

public class MultiArrayDimensionMessage: RBSMessage {
	public var label: String?
	public var size: UInt32 = 0
	public var stride: UInt32 = 0

    public override func mapping(map: Map) {
	    label <- map["label"]
		size <- map["size"]
		stride <- map["stride"]
    }
}
