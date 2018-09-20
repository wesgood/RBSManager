//
//  PointMessage.swift
//  Pods
//
//  Created by Wes Goodhoofd on 2018-01-11.
//

import UIKit
import ObjectMapper

public class PointMessage: RBSMessage {
    public var x: Float64 = 0
    public var y: Float64 = 0
    public var z: Float64 = 0
    
    public override func mapping(map: Map) {
        x <- map["x"]
        y <- map["y"]
        z <- map["z"]
    }
}
