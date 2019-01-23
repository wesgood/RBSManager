//
//  KeyValueMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class KeyValueMessage: RBSMessage {
	public var key: string
	public var value: string
    

    public override func mapping(map: Map) {
	    key <- map["key"]
		value <- map["value"]
    }
}
