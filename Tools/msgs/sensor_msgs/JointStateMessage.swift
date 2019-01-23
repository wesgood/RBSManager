//
//  JointStateMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class JointStateMessage: RBSMessage {
	public var header: HeaderMessage?
	public var name: string[] = [string[]]()
	public var position: float64[] = [float64[]]()
	public var velocity: float64[] = [float64[]]()
	public var effort: float64[] = [float64[]]()
    
	public override init() {
		super.init()
		header = HeaderMessage()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    header <- map["header"]
		name <- map["name"]
		position <- map["position"]
		velocity <- map["velocity"]
		effort <- map["effort"]
    }
}
