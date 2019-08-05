//
//  TemperatureMessage.swift
//  RBSManager
//
//  Created by Wes Goodhoofd on 2019-08-03.
//

import UIKit
import ObjectMapper

public class TemperatureMessage: RBSMessage {
    public var temperature: Float64 = 0
    public var header: HeaderMessage?
    
    public override init() {
        super.init()
        header = HeaderMessage()
    }
    
    public required init?(map: Map) {
        super.init(map: map)
    }
    
    override public func mapping(map: Map) {
        header <- map["header"]
        temperature <- map["temperature"]
    }
}
