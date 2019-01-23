//
//  BatteryStateMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class BatteryStateMessage: RBSMessage {
	public var POWER_SUPPLY_STATUS_UNKNOWN: uint8 = 0
	public var POWER_SUPPLY_STATUS_CHARGING: uint8 = 0
	public var POWER_SUPPLY_STATUS_DISCHARGING: uint8 = 0
	public var POWER_SUPPLY_STATUS_NOT_CHARGING: uint8 = 0
	public var POWER_SUPPLY_STATUS_FULL: uint8 = 0
	public var POWER_SUPPLY_HEALTH_UNKNOWN: uint8 = 0
	public var POWER_SUPPLY_HEALTH_GOOD: uint8 = 0
	public var POWER_SUPPLY_HEALTH_OVERHEAT: uint8 = 0
	public var POWER_SUPPLY_HEALTH_DEAD: uint8 = 0
	public var POWER_SUPPLY_HEALTH_OVERVOLTAGE: uint8 = 0
	public var POWER_SUPPLY_HEALTH_UNSPEC_FAILURE: uint8 = 0
	public var POWER_SUPPLY_HEALTH_COLD: uint8 = 0
	public var POWER_SUPPLY_HEALTH_WATCHDOG_TIMER_EXPIRE: uint8 = 0
	public var POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE: uint8 = 0
	public var POWER_SUPPLY_TECHNOLOGY_UNKNOWN: uint8 = 0
	public var POWER_SUPPLY_TECHNOLOGY_NIMH: uint8 = 0
	public var POWER_SUPPLY_TECHNOLOGY_LION: uint8 = 0
	public var POWER_SUPPLY_TECHNOLOGY_LIPO: uint8 = 0
	public var POWER_SUPPLY_TECHNOLOGY_LIFE: uint8 = 0
	public var POWER_SUPPLY_TECHNOLOGY_NICD: uint8 = 0
	public var POWER_SUPPLY_TECHNOLOGY_LIMN: uint8 = 0
	public var header: HeaderMessage?
	public var voltage: float32 = 0
	public var current: float32 = 0
	public var charge: float32 = 0
	public var capacity: float32 = 0
	public var design_capacity: float32 = 0
	public var percentage: float32 = 0
	public var power_supply_status: uint8 = 0
	public var power_supply_health: uint8 = 0
	public var power_supply_technology: uint8 = 0
	public var present: bool = false
	public var cell_voltage: float32[] = [float32[]]()
	public var If: #
	public var location: string
	public var serial_number: string
    
	public override init() {
		super.init()
		header = HeaderMessage()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    POWER_SUPPLY_STATUS_UNKNOWN <- map["POWER_SUPPLY_STATUS_UNKNOWN"]
		POWER_SUPPLY_STATUS_CHARGING <- map["POWER_SUPPLY_STATUS_CHARGING"]
		POWER_SUPPLY_STATUS_DISCHARGING <- map["POWER_SUPPLY_STATUS_DISCHARGING"]
		POWER_SUPPLY_STATUS_NOT_CHARGING <- map["POWER_SUPPLY_STATUS_NOT_CHARGING"]
		POWER_SUPPLY_STATUS_FULL <- map["POWER_SUPPLY_STATUS_FULL"]
		POWER_SUPPLY_HEALTH_UNKNOWN <- map["POWER_SUPPLY_HEALTH_UNKNOWN"]
		POWER_SUPPLY_HEALTH_GOOD <- map["POWER_SUPPLY_HEALTH_GOOD"]
		POWER_SUPPLY_HEALTH_OVERHEAT <- map["POWER_SUPPLY_HEALTH_OVERHEAT"]
		POWER_SUPPLY_HEALTH_DEAD <- map["POWER_SUPPLY_HEALTH_DEAD"]
		POWER_SUPPLY_HEALTH_OVERVOLTAGE <- map["POWER_SUPPLY_HEALTH_OVERVOLTAGE"]
		POWER_SUPPLY_HEALTH_UNSPEC_FAILURE <- map["POWER_SUPPLY_HEALTH_UNSPEC_FAILURE"]
		POWER_SUPPLY_HEALTH_COLD <- map["POWER_SUPPLY_HEALTH_COLD"]
		POWER_SUPPLY_HEALTH_WATCHDOG_TIMER_EXPIRE <- map["POWER_SUPPLY_HEALTH_WATCHDOG_TIMER_EXPIRE"]
		POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE <- map["POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE"]
		POWER_SUPPLY_TECHNOLOGY_UNKNOWN <- map["POWER_SUPPLY_TECHNOLOGY_UNKNOWN"]
		POWER_SUPPLY_TECHNOLOGY_NIMH <- map["POWER_SUPPLY_TECHNOLOGY_NIMH"]
		POWER_SUPPLY_TECHNOLOGY_LION <- map["POWER_SUPPLY_TECHNOLOGY_LION"]
		POWER_SUPPLY_TECHNOLOGY_LIPO <- map["POWER_SUPPLY_TECHNOLOGY_LIPO"]
		POWER_SUPPLY_TECHNOLOGY_LIFE <- map["POWER_SUPPLY_TECHNOLOGY_LIFE"]
		POWER_SUPPLY_TECHNOLOGY_NICD <- map["POWER_SUPPLY_TECHNOLOGY_NICD"]
		POWER_SUPPLY_TECHNOLOGY_LIMN <- map["POWER_SUPPLY_TECHNOLOGY_LIMN"]
		header <- map["header"]
		voltage <- map["voltage"]
		current <- map["current"]
		charge <- map["charge"]
		capacity <- map["capacity"]
		design_capacity <- map["design_capacity"]
		percentage <- map["percentage"]
		power_supply_status <- map["power_supply_status"]
		power_supply_health <- map["power_supply_health"]
		power_supply_technology <- map["power_supply_technology"]
		present <- map["present"]
		cell_voltage <- map["cell_voltage"]
		If <- map["If"]
		location <- map["location"]
		serial_number <- map["serial_number"]
    }
}
