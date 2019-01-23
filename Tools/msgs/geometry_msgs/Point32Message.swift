//
//  Point32Message.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class Point32Message: RBSMessage {
	public var x: float32 = 0
	public var y: float32 = 0
	public var z: float32 = 0
    

    public override func mapping(map: Map) {
	    x <- map["x"]
		y <- map["y"]
		z <- map["z"]
    }
}
