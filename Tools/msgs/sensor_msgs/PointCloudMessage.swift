//
//  PointCloudMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class PointCloudMessage: RBSMessage {
	public var header: HeaderMessage?
	public var points: Point32Message[]? = [Point32Message[]]()
	public var channels: ChannelFloat32Message[]? = [ChannelFloat32Message[]]()
    
	public override init() {
		super.init()
		header = HeaderMessage()
	points = Point32Message[]()
	channels = ChannelFloat32Message[]()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    header <- map["header"]
		points <- map["points"]
		channels <- map["channels"]
    }
}
