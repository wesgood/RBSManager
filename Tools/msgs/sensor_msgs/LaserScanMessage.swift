//
//  LaserScanMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class LaserScanMessage: RBSMessage {
	public var header: HeaderMessage?
	public var the: #
	public var in: #
	public var the: #
	public var with: #
	public var angle_min: float32 = 0
	public var angle_max: float32 = 0
	public var angle_increment: float32 = 0
	public var time_increment: float32 = 0
	public var is: #
	public var of: #
	public var scan_time: float32 = 0
	public var range_min: float32 = 0
	public var range_max: float32 = 0
	public var ranges: float32[] = [float32[]]()
	public var intensities: float32[] = [float32[]]()
	public var device: #
	public var the: #
    
	public override init() {
		super.init()
		header = HeaderMessage()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    header <- map["header"]
		the <- map["the"]
		in <- map["in"]
		the <- map["the"]
		with <- map["with"]
		angle_min <- map["angle_min"]
		angle_max <- map["angle_max"]
		angle_increment <- map["angle_increment"]
		time_increment <- map["time_increment"]
		is <- map["is"]
		of <- map["of"]
		scan_time <- map["scan_time"]
		range_min <- map["range_min"]
		range_max <- map["range_max"]
		ranges <- map["ranges"]
		intensities <- map["intensities"]
		device <- map["device"]
		the <- map["the"]
    }
}
