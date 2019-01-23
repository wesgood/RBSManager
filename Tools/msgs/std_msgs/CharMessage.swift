//
//  CharMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class CharMessage: RBSMessage {
	public var data: char
    

    public override func mapping(map: Map) {
	    data <- map["data"]
    }
}
