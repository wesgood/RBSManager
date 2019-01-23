//
//  CameraInfoMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class CameraInfoMessage: RBSMessage {
	public var header: HeaderMessage?
	public var Header: #
	public var origin: #
	public var +x: #
	public var +y: #
	public var +z: #
	public var height: uint32 = 0
	public var width: uint32 = 0
	public var distortion_model: string
	public var D: float64[] = [float64[]]()
	public var K: float64[9] = [float64[9]]()
	public var R: float64[9] = [float64[9]]()
	public var P: float64[12] = [float64[12]]()
	public var binning_x: uint32 = 0
	public var binning_y: uint32 = 0
	public var roi: RegionOfInterestMessage? = 0
    
	public override init() {
		super.init()
		header = HeaderMessage()
	roi = RegionOfInterestMessage()
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
		height <- map["height"]
		width <- map["width"]
		distortion_model <- map["distortion_model"]
		D <- map["D"]
		K <- map["K"]
		R <- map["R"]
		P <- map["P"]
		binning_x <- map["binning_x"]
		binning_y <- map["binning_y"]
		roi <- map["roi"]
    }
}
