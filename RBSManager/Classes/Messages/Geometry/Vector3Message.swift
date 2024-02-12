//
//  Vector3Message.swift
//  RBSManager
//
//  Created by Wes Goodhoofd on 2018-01-10.
//

import Foundation
import ObjectMapper

public class Vector3Message: RBSMessage {
    public var x: Float64 = 0
    public var y: Float64 = 0
    public var z: Float64 = 0

    override public func mapping(map: Map) {
        x <- map["x"]
        y <- map["y"]
        z <- map["z"]
    }
}
