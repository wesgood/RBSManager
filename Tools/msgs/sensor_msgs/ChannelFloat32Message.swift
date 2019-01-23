//
//  ChannelFloat32Message.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class ChannelFloat32Message: RBSMessage {
	public var name: string
	public var values: float32[] = [float32[]]()
    

    public override func mapping(map: Map) {
	    name <- map["name"]
		values <- map["values"]
    }
}
