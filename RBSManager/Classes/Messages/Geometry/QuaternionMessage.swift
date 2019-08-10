//
//  QuaternionMessage.swift
//  RBSManager
//
//  Created by Wes Goodhoofd on 2019-08-07.
//

import UIKit
import ObjectMapper

public class QuaternionMessage: RBSMessage {
    public var x: Float64 = 0
    public var y: Float64 = 0
    public var z: Float64 = 0
    public var w: Float64 = 0
    
    public override func mapping(map: Map) {
        x <- map["x"]
        y <- map["y"]
        z <- map["z"]
        w <- map["w"]
    }
}
