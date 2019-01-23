//
//  ImageMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class ImageMessage: RBSMessage {
	public var header: HeaderMessage?
	public var Header: #
	public var origin: #
	public var +x: #
	public var +y: #
	public var +z: #
	public var If: #
	public var message: #
	public var the: #
	public var height: uint32 = 0
	public var width: uint32 = 0
	public var encoding: string
	public var taken: #
	public var is_bigendian: uint8 = 0
	public var step: uint32 = 0
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
		If <- map["If"]
		message <- map["message"]
		the <- map["the"]
		height <- map["height"]
		width <- map["width"]
		encoding <- map["encoding"]
		taken <- map["taken"]
		is_bigendian <- map["is_bigendian"]
		step <- map["step"]
		data <- map["data"]
    }
}
