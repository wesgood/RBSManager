//
//  Vector3Message.swift
//  RBSManager
//
//  Created by Wes Goodhoofd on 2018-01-10.
//

import UIKit
import ObjectMapper

public class Vector3Message: RBSMessage {
    var x: Float?
    var y: Float?
    var z: Float?
    
    override public func mapping(map: Map) {
        x <- map["x"]
        y <- map["y"]
        z <- map["z"]
    }
}
