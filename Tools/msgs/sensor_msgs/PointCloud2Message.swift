//
//  PointCloud2Message.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class PointCloud2Message: RBSMessage {
	public var header: HeaderMessage?
	public var height: uint32 = 0
	public var width: uint32 = 0
	public var fields: PointFieldMessage[]? = [PointFieldMessage[]]()
	public var is_bigendian: bool = false
	public var point_step: uint32 = 0
	public var row_step: uint32 = 0
	public var data: uint8[] = [uint8[]]()
	public var is_dense: bool = false
    
	public override init() {
		super.init()
		header = HeaderMessage()
	fields = PointFieldMessage[]()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    header <- map["header"]
		height <- map["height"]
		width <- map["width"]
		fields <- map["fields"]
		is_bigendian <- map["is_bigendian"]
		point_step <- map["point_step"]
		row_step <- map["row_step"]
		data <- map["data"]
		is_dense <- map["is_dense"]
    }
}
