//
//  MultiArrayLayoutMessage.swift
//
//  Created by wesgoodhoofd on 2018-09-19.
//

import UIKit
import ObjectMapper

public class MultiArrayLayoutMessage: RBSMessage {
	public var dim: [MultiArrayDimensionMessage]?
	public var data_offset: UInt32 = 0
    
	public override init() {
		super.init()
		dim = [MultiArrayDimensionMessage]()
	}
    
    public required init?(map: Map) {
        super.init(map: map)
    }

    public override func mapping(map: Map) {
	    dim <- map["dim"]
		data_offset <- map["data_offset"]
    }
}
