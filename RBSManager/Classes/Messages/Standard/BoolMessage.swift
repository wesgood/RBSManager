//
//  BoolMessage.swift
//
//  Created by wesgoodhoofd on 2018-09-19.
//

import UIKit
import ObjectMapper

public class BoolMessage: RBSMessage {
	public var data: Bool = false
    

    public override func mapping(map: Map) {
	    data <- map["data"]
    }
}
