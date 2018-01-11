//
//  TwistMessage.swift
//  ObjectMapper
//
//  Created by Wes Goodhoofd on 2018-01-10.
//

import UIKit
import ObjectMapper

public class TwistMessage: RBSMessage {
    var linear: Vector3Message?
    var angular: Vector3Message?
    
    override public func mapping(map: Map) {
        linear <- map["linear"]
        angular <- map["angular"]
    }
}
