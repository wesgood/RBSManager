//
//  MultiArrayLayoutMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class MultiArrayLayoutMessage: RBSMessage {
	public var dim: MultiArrayDimension[] = [MultiArrayDimension[]]()
	public var data_offset: uint32 = 0
    

    public override func mapping(map: Map) {
	    dim <- map["dim"]
		data_offset <- map["data_offset"]
    }
}
