//
//  CharMessage.swift
//
//  Created by wesgoodhoofd on 2018-09-19.
//

import UIKit
import ObjectMapper

public class CharMessage: RBSMessage {
	public var data: Character?
    

    public override func mapping(map: Map) {
	    data <- map["data"]
    }
}
