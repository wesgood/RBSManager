//
//  ByteMultiArrayMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class ByteMultiArrayMessage: RBSMessage {
	public var layout: MultiArrayLayout
	public var data: byte[] = [byte[]]()
    

    public override func mapping(map: Map) {
	    layout <- map["layout"]
		data <- map["data"]
    }
}
