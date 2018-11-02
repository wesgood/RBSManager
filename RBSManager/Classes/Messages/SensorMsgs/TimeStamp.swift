//
//  ImageStampMessage.swift
//
//  Created by helming on 2018-10-24.
//

import UIKit
import ObjectMapper
import RBSManager

public class TimeStamp: RBSMessage {
	public var secs: Int = 0
	public var nsecs: Int = 0
    

    public override func mapping(map: Map) {
	    secs <- map["secs"]
		nsecs <- map["nsecs"]
    }
}
