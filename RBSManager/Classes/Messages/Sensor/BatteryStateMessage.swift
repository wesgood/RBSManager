//
//  BatteryStateMessage.swift
//  RBSManager
//
//  Created by Wes Goodhoofd on 2019-07-26.
//

import UIKit
import ObjectMapper

public enum PowerSupplyStatus: UInt8 {
    case POWER_SUPPLY_STATUS_UNKNOWN = 0
    case POWER_SUPPLY_STATUS_CHARGING
    case POWER_SUPPLY_STATUS_DISCHARGING
    case POWER_SUPPLY_STATUS_NOT_CHARGING
    case POWER_SUPPLY_STATUS_FULL
}

public enum PowerSupplyHealth: UInt8 {
    case POWER_SUPPLY_HEALTH_UNKNOWN = 0
    case POWER_SUPPLY_HEALTH_GOOD = 1
    case POWER_SUPPLY_HEALTH_OVERHEAT = 2
    case POWER_SUPPLY_HEALTH_DEAD = 3
    case POWER_SUPPLY_HEALTH_OVERVOLTAGE = 4
    case POWER_SUPPLY_HEALTH_UNSPEC_FAILURE = 5
    case POWER_SUPPLY_HEALTH_COLD = 6
    case POWER_SUPPLY_HEALTH_WATCHDOG_TIMER_EXPIRE = 7
    case POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE = 8
}

public enum PowerSupplyTechnology: UInt8 {
    case POWER_SUPPLY_TECHNOLOGY_UNKNOWN = 0
    case POWER_SUPPLY_TECHNOLOGY_NIMH = 1
    case POWER_SUPPLY_TECHNOLOGY_LION = 2
    case POWER_SUPPLY_TECHNOLOGY_LIPO = 3
    case POWER_SUPPLY_TECHNOLOGY_LIFE = 4
    case POWER_SUPPLY_TECHNOLOGY_NICD = 5
    case POWER_SUPPLY_TECHNOLOGY_LIMN = 6
}

public class BatteryStateMessage: RBSMessage {
    public var header: HeaderMessage?
    public var voltage: Float32 = 0
    public var current: Float32 = 0
    public var charge: Float32 = 0
    public var capacity: Float32 = 0
    public var design_capacity: Float32 = 0
    public var percentage: Float32 = 0
    public var power_supply_health: PowerSupplyHealth = .POWER_SUPPLY_HEALTH_UNKNOWN
    public var power_supply_status: PowerSupplyStatus = .POWER_SUPPLY_STATUS_UNKNOWN
    public var power_supply_technology: PowerSupplyTechnology = .POWER_SUPPLY_TECHNOLOGY_UNKNOWN
    public var present: Bool = false
    public var cell_voltage: [Float32]?
    public var location: String?
    public var serial_number: String?
    
    public override init() {
        super.init()
        header = HeaderMessage()
    }
    
    public required init?(map: Map) {
        super.init(map: map)
    }
    
    override public func mapping(map: Map) {
        header <- map["header"]
        voltage <- map["voltage"]
        current <- map["current"]
        charge <- map["charge"]
        capacity <- map["capacity"]
        design_capacity <- map["design_capacity"]
        percentage <- map["percentage"]
        power_supply_health <- map["power_supply_health"]
        power_supply_status <- map["power_supply_status"]
        power_supply_technology <- map["power_supply_technology"]
        present <- map["present"]
        //cell_voltage <- map["cell_voltage"]
        location <- map["location"]
        serial_number <- map["serial_number"]
    }
}
