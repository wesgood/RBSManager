//
//  Int8MultiArrayMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class Int8MultiArrayMessage: RBSMessage {
	public var layout: MultiArrayLayout
	public var data: int8[] = [int8[]]()
    

    public override func mapping(map: Map) {
	    layout <- map["layout"]
		data <- map["data"]
    }
}
