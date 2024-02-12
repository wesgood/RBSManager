//
//  BatteryStateMessage.swift
//  RBSManager
//
//  Created by Wes Goodhoofd on 2019-07-26.
//

import Foundation
import ObjectMapper

public enum PowerSupplyStatus: UInt8 {
    case powerSupplyStatusUnknown = 0
    case powerSupplyStatusCharging
    case powerSupplyStatusDischarging
    case powerSupplyStatusNotCharging
    case powerSupplyStatusFull
}

public enum PowerSupplyHealth: UInt8 {
    case powerSupplyHealthUnknown = 0
    case powerSupplyHealthGood = 1
    case powerSupplyHealthOverheat = 2
    case powerSupplyHealthDead = 3
    case powerSupplyHealthOverVoltage = 4
    case powerSupplyHealthUnspecFailure = 5
    case powerSupplyHealthCold = 6
    case powerSupplyHealthWatchdogTimerExpire = 7
    case powerSupplyHealthSafetyTimerExpire = 8
}

public enum PowerSupplyTechnology: UInt8 {
    case powerSupplyTechnologyUnknown = 0
    case powerSupplyTechnologyNIMH = 1
    case powerSupplyTechnologyLION = 2
    case powerSupplyTechnologyLIPO = 3
    case powerSupplyTechnologyLIFE = 4
    case powerSupplyTechnologyNICD = 5
    case powerSupplyTechnologyLIMN = 6
}

public class BatteryStateMessage: RBSMessage {
    public var header: HeaderMessage?
    public var voltage: Float32 = 0
    public var current: Float32 = 0
    public var charge: Float32 = 0
    public var capacity: Float32 = 0
    public var designCapacity: Float32 = 0
    public var percentage: Float32 = 0
    public var powerSupplyHealth: PowerSupplyHealth = .powerSupplyHealthUnknown
    public var powerSupplyStatus: PowerSupplyStatus = .powerSupplyStatusUnknown
    public var powerSupplyTechnology: PowerSupplyTechnology = .powerSupplyTechnologyUnknown
    public var present: Bool = false
    public var cellVoltage: [Float32]?
    public var location: String?
    public var serialNumber: String?

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
        designCapacity <- map["design_capacity"]
        percentage <- map["percentage"]
        powerSupplyHealth <- map["power_supply_health"]
        powerSupplyStatus <- map["power_supply_status"]
        powerSupplyTechnology <- map["power_supply_technology"]
        present <- map["present"]
        // cell_voltage <- map["cell_voltage"]
        location <- map["location"]
        serialNumber <- map["serial_number"]
    }
}
