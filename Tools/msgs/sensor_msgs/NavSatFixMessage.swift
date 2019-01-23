//
//  NavSatFixMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class NavSatFixMessage: RBSMessage {
	public var header: HeaderMessage?
	public var status: NavSatStatusMessage?
	public var latitude: float64 = 0
	public var longitude: float64 = 0
	public var altitude: float64 = 0
	public var position_covariance: float64[9] = [float64[9]]()
	public var COVARIANCE_TYPE_UNKNOWN: uint8 = 0
	public var COVARIANCE_TYPE_APPROXIMATED: uint8 = 0
	public var COVARIANCE_TYPE_DIAGONAL_KNOWN: uint8 = 0
	public var COVARIANCE_TYPE_KNOWN: uint8 = 0
	public var position_covariance_type: uint8 = 0
    
	public override init() {
		super.init()
		header = HeaderMessage()
	status = NavSatStatusMessage()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    header <- map["header"]
		status <- map["status"]
		latitude <- map["latitude"]
		longitude <- map["longitude"]
		altitude <- map["altitude"]
		position_covariance <- map["position_covariance"]
		COVARIANCE_TYPE_UNKNOWN <- map["COVARIANCE_TYPE_UNKNOWN"]
		COVARIANCE_TYPE_APPROXIMATED <- map["COVARIANCE_TYPE_APPROXIMATED"]
		COVARIANCE_TYPE_DIAGONAL_KNOWN <- map["COVARIANCE_TYPE_DIAGONAL_KNOWN"]
		COVARIANCE_TYPE_KNOWN <- map["COVARIANCE_TYPE_KNOWN"]
		position_covariance_type <- map["position_covariance_type"]
    }
}
