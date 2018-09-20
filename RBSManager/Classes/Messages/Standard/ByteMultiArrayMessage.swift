//
//  ByteMultiArrayMessage.swift
//
//  Created by wesgoodhoofd on 2018-09-19.
//

import UIKit
import ObjectMapper

public class ByteMultiArrayMessage: RBSMessage {
	public var layout: MultiArrayLayoutMessage?
	public var data = [UInt8]()
    
	public override init() {
		super.init()
		layout = MultiArrayLayoutMessage()
	}
    
    public required init?(map: Map) {
        super.init(map: map)
    }

    public override func mapping(map: Map) {
	    layout <- map["layout"]
		data <- map["data"]
    }
}
