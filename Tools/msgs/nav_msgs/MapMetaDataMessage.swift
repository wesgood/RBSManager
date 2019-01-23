//
//  MapMetaDataMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class MapMetaDataMessage: RBSMessage {
	public var map_load_time: time
	public var resolution: float32 = 0
	public var width: uint32 = 0
	public var height: uint32 = 0
	public var origin: PoseMessage?
    
	public override init() {
		super.init()
		origin = PoseMessage()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    map_load_time <- map["map_load_time"]
		resolution <- map["resolution"]
		width <- map["width"]
		height <- map["height"]
		origin <- map["origin"]
    }
}
