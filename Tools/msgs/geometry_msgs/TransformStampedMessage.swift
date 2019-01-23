//
//  TransformStampedMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class TransformStampedMessage: RBSMessage {
	public var header: HeaderMessage?
	public var child_frame_id: string
	public var transform: TransformMessage?
    
	public override init() {
		super.init()
		header = HeaderMessage()
	transform = TransformMessage()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    header <- map["header"]
		child_frame_id <- map["child_frame_id"]
		transform <- map["transform"]
    }
}
