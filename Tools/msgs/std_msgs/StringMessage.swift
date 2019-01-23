//
//  StringMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class StringMessage: RBSMessage {
	public var data: string
    

    public override func mapping(map: Map) {
	    data <- map["data"]
    }
}
