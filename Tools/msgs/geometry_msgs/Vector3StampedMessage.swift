//
//  Vector3StampedMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class Vector3StampedMessage: RBSMessage {
	public var header: HeaderMessage?
	public var vector: Vector3Message?
    
	public override init() {
		super.init()
		header = HeaderMessage()
	vector = Vector3Message()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    header <- map["header"]
		vector <- map["vector"]
    }
}
