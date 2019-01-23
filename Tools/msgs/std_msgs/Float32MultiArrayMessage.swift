//
//  Float32MultiArrayMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class Float32MultiArrayMessage: RBSMessage {
	public var layout: MultiArrayLayout
	public var data: float32[] = [float32[]]()
    

    public override func mapping(map: Map) {
	    layout <- map["layout"]
		data <- map["data"]
    }
}
