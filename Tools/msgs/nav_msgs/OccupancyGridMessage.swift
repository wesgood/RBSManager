//
//  OccupancyGridMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class OccupancyGridMessage: RBSMessage {
	public var header: HeaderMessage?
	public var info: MapMetaDataMessage?
	public var data: int8[] = [int8[]]()
    
	public override init() {
		super.init()
		header = HeaderMessage()
	info = MapMetaDataMessage()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    header <- map["header"]
		info <- map["info"]
		data <- map["data"]
    }
}
