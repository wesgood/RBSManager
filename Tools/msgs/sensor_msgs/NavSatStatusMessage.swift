//
//  NavSatStatusMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class NavSatStatusMessage: RBSMessage {
	public var STATUS_NO_FIX: int8 = 0
	public var STATUS_FIX: int8 = 0
	public var STATUS_SBAS_FIX: int8 = 0
	public var STATUS_GBAS_FIX: int8 = 0
	public var status: int8 = 0
	public var SERVICE_GPS: uint16 = 0
	public var SERVICE_GLONASS: uint16 = 0
	public var SERVICE_COMPASS: uint16 = 0
	public var SERVICE_GALILEO: uint16 = 0
	public var service: uint16 = 0
    

    public override func mapping(map: Map) {
	    STATUS_NO_FIX <- map["STATUS_NO_FIX"]
		STATUS_FIX <- map["STATUS_FIX"]
		STATUS_SBAS_FIX <- map["STATUS_SBAS_FIX"]
		STATUS_GBAS_FIX <- map["STATUS_GBAS_FIX"]
		status <- map["status"]
		SERVICE_GPS <- map["SERVICE_GPS"]
		SERVICE_GLONASS <- map["SERVICE_GLONASS"]
		SERVICE_COMPASS <- map["SERVICE_COMPASS"]
		SERVICE_GALILEO <- map["SERVICE_GALILEO"]
		service <- map["service"]
    }
}
