//
//  LaserEchoMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class LaserEchoMessage: RBSMessage {
	public var echoes: float32[] = [float32[]]()
	public var Each: #
    

    public override func mapping(map: Map) {
	    echoes <- map["echoes"]
		Each <- map["Each"]
    }
}
