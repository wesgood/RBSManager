//
//  JoyMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class JoyMessage: RBSMessage {
	public var header: HeaderMessage?
	public var axes: float32[] = [float32[]]()
	public var buttons: int32[] = [int32[]]()
    
	public override init() {
		super.init()
		header = HeaderMessage()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    header <- map["header"]
		axes <- map["axes"]
		buttons <- map["buttons"]
    }
}
