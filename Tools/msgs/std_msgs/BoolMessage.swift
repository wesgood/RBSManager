//
//  BoolMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class BoolMessage: RBSMessage {
	public var data: bool = false
    

    public override func mapping(map: Map) {
	    data <- map["data"]
    }
}
