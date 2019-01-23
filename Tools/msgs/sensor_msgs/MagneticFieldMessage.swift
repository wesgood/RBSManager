//
//  MagneticFieldMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class MagneticFieldMessage: RBSMessage {
	public var Measurement: #
	public var If: #
	public var (if: #
	public var put: #just
	public var A: #
	public var and: #
	public var other: #
	public var header: HeaderMessage?
	public var field: #
	public var frame_id: #
	public var of: #
	public var magnetic_field: Vector3Message?
	public var field: #
	public var If: #
	public var put: #
	public var magnetic_field_covariance: float64[9] = [float64[9]]()
	public var 0: #
    
	public override init() {
		super.init()
		header = HeaderMessage()
	magnetic_field = Vector3Message()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    Measurement <- map["Measurement"]
		If <- map["If"]
		(if <- map["(if"]
		put <- map["put"]
		A <- map["A"]
		and <- map["and"]
		other <- map["other"]
		header <- map["header"]
		field <- map["field"]
		frame_id <- map["frame_id"]
		of <- map["of"]
		magnetic_field <- map["magnetic_field"]
		field <- map["field"]
		If <- map["If"]
		put <- map["put"]
		magnetic_field_covariance <- map["magnetic_field_covariance"]
		0 <- map["0"]
    }
}
