//
//  InertiaMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class InertiaMessage: RBSMessage {
	public var m: float64 = 0
	public var com: Vector3Message?
	public var ixx: float64 = 0
	public var ixy: float64 = 0
	public var ixz: float64 = 0
	public var iyy: float64 = 0
	public var iyz: float64 = 0
	public var izz: float64 = 0
    
	public override init() {
		super.init()
		com = Vector3Message()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    m <- map["m"]
		com <- map["com"]
		ixx <- map["ixx"]
		ixy <- map["ixy"]
		ixz <- map["ixz"]
		iyy <- map["iyy"]
		iyz <- map["iyz"]
		izz <- map["izz"]
    }
}
