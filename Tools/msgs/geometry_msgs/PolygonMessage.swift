//
//  PolygonMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class PolygonMessage: RBSMessage {
	public var points: Point32Message[]? = [Point32Message[]]()
    
	public override init() {
		super.init()
		points = Point32Message[]()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    points <- map["points"]
    }
}
