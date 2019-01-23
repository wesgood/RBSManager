//
//  MultiArrayDimensionMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class MultiArrayDimensionMessage: RBSMessage {
	public var label: string
	public var size: uint32 = 0
	public var stride: uint32 = 0
    

    public override func mapping(map: Map) {
	    label <- map["label"]
		size <- map["size"]
		stride <- map["stride"]
    }
}
