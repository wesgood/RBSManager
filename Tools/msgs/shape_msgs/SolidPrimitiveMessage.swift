//
//  SolidPrimitiveMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class SolidPrimitiveMessage: RBSMessage {
	public var BOX=1: uint8 = 0
	public var SPHERE=2: uint8 = 0
	public var CYLINDER=3: uint8 = 0
	public var CONE=4: uint8 = 0
	public var type: uint8 = 0
	public var dimensions: float64[] = [float64[]]()
	public var BOX_X=0: uint8 = 0
	public var BOX_Y=1: uint8 = 0
	public var BOX_Z=2: uint8 = 0
	public var SPHERE_RADIUS=0: uint8 = 0
	public var CYLINDER_HEIGHT=0: uint8 = 0
	public var CYLINDER_RADIUS=1: uint8 = 0
	public var CONE_HEIGHT=0: uint8 = 0
	public var CONE_RADIUS=1: uint8 = 0
    

    public override func mapping(map: Map) {
	    BOX=1 <- map["BOX=1"]
		SPHERE=2 <- map["SPHERE=2"]
		CYLINDER=3 <- map["CYLINDER=3"]
		CONE=4 <- map["CONE=4"]
		type <- map["type"]
		dimensions <- map["dimensions"]
		BOX_X=0 <- map["BOX_X=0"]
		BOX_Y=1 <- map["BOX_Y=1"]
		BOX_Z=2 <- map["BOX_Z=2"]
		SPHERE_RADIUS=0 <- map["SPHERE_RADIUS=0"]
		CYLINDER_HEIGHT=0 <- map["CYLINDER_HEIGHT=0"]
		CYLINDER_RADIUS=1 <- map["CYLINDER_RADIUS=1"]
		CONE_HEIGHT=0 <- map["CONE_HEIGHT=0"]
		CONE_RADIUS=1 <- map["CONE_RADIUS=1"]
    }
}
