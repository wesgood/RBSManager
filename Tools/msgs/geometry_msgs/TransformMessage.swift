//
//  TransformMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class TransformMessage: RBSMessage {
	public var translation: Vector3Message?
	public var rotation: QuaternionMessage?
    
	public override init() {
		super.init()
		translation = Vector3Message()
	rotation = QuaternionMessage()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    translation <- map["translation"]
		rotation <- map["rotation"]
    }
}
