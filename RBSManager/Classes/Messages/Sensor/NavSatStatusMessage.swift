//
//  NavSatStatusMessage.swift
//  ObjectMapper
//
//  Created by Wes Goodhoofd on 2019-07-13.
//

import UIKit
import ObjectMapper

public enum NavSatStatus: Int8 {
    case STATUS_NO_FIX = -1
    case STATUS_FIX
    case STATUS_SBAS_FIX
    case STATUS_GBAS_FIX
}

public enum NavSatService: UInt16 {
    case SERVICE_GPS =     1
    case SERVICE_GLONASS = 2
    case SERVICE_COMPASS = 4
    case SERVICE_GALILEO = 8
}

public class NavSatStatusMessage: RBSMessage {
    public var service: NavSatService!
    public var status: NavSatStatus!
    
    override public func mapping(map: Map) {
        service <- map["service"]
        status <- map["status"]
    }
}
