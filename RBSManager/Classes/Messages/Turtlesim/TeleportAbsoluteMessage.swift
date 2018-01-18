//
//  TeleportAbsoluteMessage.swift
//  Pods
//
//  Created by Wes Goodhoofd on 2018-01-17.
//

import UIKit
import ObjectMapper

public class TeleportAbsoluteMessage: RBSMessage {
    public var x: Float64 = 0
    public var y: Float64 = 0
    public var theta: Float64 = 0
    
    override public func mapping(map: Map) {
        x <- map["x"]
        y <- map["y"]
        theta <- map["theta"]
    }
}
