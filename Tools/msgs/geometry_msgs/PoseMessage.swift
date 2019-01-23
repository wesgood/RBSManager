//
//  PoseMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class PoseMessage: RBSMessage {
	public var position: PointMessage? = 0
	public var orientation: QuaternionMessage?
    
	public override init() {
		super.init()
		position = PointMessage()
	orientation = QuaternionMessage()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    position <- map["position"]
		orientation <- map["orientation"]
    }
}
