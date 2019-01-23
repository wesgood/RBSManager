//
//  PointFieldMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class PointFieldMessage: RBSMessage {
	public var INT8: uint8 = 0
	public var UINT8: uint8 = 0
	public var INT16: uint8 = 0
	public var UINT16: uint8 = 0
	public var INT32: uint8 = 0
	public var UINT32: uint8 = 0
	public var FLOAT32: uint8 = 0
	public var FLOAT64: uint8 = 0
	public var name: string
	public var offset: uint32 = 0
	public var datatype: uint8 = 0
	public var count: uint32 = 0
    

    public override func mapping(map: Map) {
	    INT8 <- map["INT8"]
		UINT8 <- map["UINT8"]
		INT16 <- map["INT16"]
		UINT16 <- map["UINT16"]
		INT32 <- map["INT32"]
		UINT32 <- map["UINT32"]
		FLOAT32 <- map["FLOAT32"]
		FLOAT64 <- map["FLOAT64"]
		name <- map["name"]
		offset <- map["offset"]
		datatype <- map["datatype"]
		count <- map["count"]
    }
}
