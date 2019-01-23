//
//  MultiDOFJointStateMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class MultiDOFJointStateMessage: RBSMessage {
	public var header: HeaderMessage?
	public var joint_names: string[] = [string[]]()
	public var transforms: TransformMessage[]? = [TransformMessage[]]()
	public var twist: TwistMessage[]? = [TwistMessage[]]()
	public var wrench: WrenchMessage[]? = [WrenchMessage[]]()
    
	public override init() {
		super.init()
		header = HeaderMessage()
	transforms = TransformMessage[]()
	twist = TwistMessage[]()
	wrench = WrenchMessage[]()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    header <- map["header"]
		joint_names <- map["joint_names"]
		transforms <- map["transforms"]
		twist <- map["twist"]
		wrench <- map["wrench"]
    }
}
