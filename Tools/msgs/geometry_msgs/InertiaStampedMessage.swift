//
//  InertiaStampedMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class InertiaStampedMessage: RBSMessage {
	public var header: HeaderMessage?
	public var inertia: InertiaMessage?
    
	public override init() {
		super.init()
		header = HeaderMessage()
	inertia = InertiaMessage()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    header <- map["header"]
		inertia <- map["inertia"]
    }
}
