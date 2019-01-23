//
//  Int64MultiArrayMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class Int64MultiArrayMessage: RBSMessage {
	public var layout: MultiArrayLayout
	public var data: int64[] = [int64[]]()
    

    public override func mapping(map: Map) {
	    layout <- map["layout"]
		data <- map["data"]
    }
}
