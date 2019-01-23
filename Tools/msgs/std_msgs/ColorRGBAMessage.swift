//
//  ColorRGBAMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class ColorRGBAMessage: RBSMessage {
	public var r: float32 = 0
	public var g: float32 = 0
	public var b: float32 = 0
	public var a: float32 = 0
    

    public override func mapping(map: Map) {
	    r <- map["r"]
		g <- map["g"]
		b <- map["b"]
		a <- map["a"]
    }
}
