//
//  AccelMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class AccelMessage: RBSMessage {
	public var linear: Vector3Message?
	public var angular: Vector3Message?
    
	public override init() {
		super.init()
		linear = Vector3Message()
	angular = Vector3Message()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    linear <- map["linear"]
		angular <- map["angular"]
    }
}
