//
//  UInt64MultiArrayMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class UInt64MultiArrayMessage: RBSMessage {
	public var layout: MultiArrayLayout
	public var data: uint64[] = [uint64[]]()
    

    public override func mapping(map: Map) {
	    layout <- map["layout"]
		data <- map["data"]
    }
}
