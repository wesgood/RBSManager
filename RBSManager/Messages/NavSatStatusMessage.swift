//
//  NavSatStatusMessage.swift
//  ObjectMapper
//
//  Created by Wes Goodhoofd on 2019-07-13.
//

import Foundation
import ObjectMapper

public enum NavSatStatus: Int8 {
    case statusNoFix = -1
    case statusFix
    case statusSbasFix
    case statusGbasFix
}

public enum NavSatService: UInt16 {
    case serviceGps = 1
    case serviceGlonass = 2
    case serviceCompass = 4
    case serviceGalileo = 8
}

public class NavSatStatusMessage: RBSMessage {
    public var service: NavSatService!
    public var status: NavSatStatus!

    override public func mapping(map: Map) {
        service <- map["service"]
        status <- map["status"]
    }
}
