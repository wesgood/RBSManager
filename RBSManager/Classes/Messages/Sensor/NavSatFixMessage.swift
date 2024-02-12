//
//  NavSatFixMessage.swift
//  ObjectMapper
//
//  Created by Wes Goodhoofd on 2019-07-13.
//

import Foundation
import ObjectMapper
import CoreLocation

public enum PositionCovarianceType: UInt8 {
    case covarianceTypeUnknown = 0
    case covarianceTypeApproximated = 1
    case covarianceTypeDiagnonalKnown = 2
    case covarianceTypeKnown = 3
}

public class NavSatFixMessage: RBSMessage {
    public var header: HeaderMessage?
    public var status: NavSatStatusMessage?
    public var latitude: Float64 = 0
    public var longitude: Float64 = 0
    public var altitude: Float64 = 0
    public var positionCovariance: [Float64]?
    public var positionCovarianceType: PositionCovarianceType?

    public override init() {
        super.init()
        header = HeaderMessage()
        status = NavSatStatusMessage()
    }

    public required init?(map: Map) {
        super.init(map: map)
    }

    override public func mapping(map: Map) {
        header <- map["header"]
        status <- map["status"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        altitude <- map["altitude"]
        positionCovariance <- map["position_covariance"]
        positionCovarianceType <- map["position_covariance_type"]
    }

    public func latitudeLabel() -> String? {
        let quadrant = (latitude > 0) ? "N" : "S"
        return String(format: "%.4f %@", latitude, quadrant)
    }

    public func longitudeLabel() -> String? {
        let quadrant = (longitude > 0) ? "E" : "W"
        return String(format: "%.4f %@", longitude, quadrant)
    }

    public func coordinate() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    public func hasFix() -> Bool {
        if let fix = status?.status {
            return fix.rawValue > NavSatStatus.statusNoFix.rawValue
        } else {
            return false
        }
    }
}
