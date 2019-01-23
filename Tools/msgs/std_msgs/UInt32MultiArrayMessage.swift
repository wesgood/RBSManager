//
//  UInt32MultiArrayMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class UInt32MultiArrayMessage: RBSMessage {
	public var layout: MultiArrayLayout
	public var data: uint32[] = [uint32[]]()
    

    public override func mapping(map: Map) {
	    layout <- map["layout"]
		data <- map["data"]
    }
}
