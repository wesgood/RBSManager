//
//  UInt16MultiArrayMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class UInt16MultiArrayMessage: RBSMessage {
	public var layout: MultiArrayLayout
	public var data: uint16[] = [uint16[]]()
    

    public override func mapping(map: Map) {
	    layout <- map["layout"]
		data <- map["data"]
    }
}
