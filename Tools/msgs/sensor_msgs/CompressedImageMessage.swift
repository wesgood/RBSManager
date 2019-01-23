//
//  CompressedImageMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class CompressedImageMessage: RBSMessage {
	public var header: HeaderMessage?
	public var Header: #
	public var origin: #
	public var +x: #
	public var +y: #
	public var +z: #
	public var format: string
	public var Acceptable: #
	public var jpeg,: #
	public var data: uint8[] = [uint8[]]()
    
	public override init() {
		super.init()
		header = HeaderMessage()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    header <- map["header"]
		Header <- map["Header"]
		origin <- map["origin"]
		+x <- map["+x"]
		+y <- map["+y"]
		+z <- map["+z"]
		format <- map["format"]
		Acceptable <- map["Acceptable"]
		jpeg, <- map["jpeg,"]
		data <- map["data"]
    }
}
