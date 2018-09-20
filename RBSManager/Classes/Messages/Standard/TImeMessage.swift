//
//  TImeMessage.swift
//  Pods
//
//  Created by Wes Goodhoofd on 2018-01-11.
//

import UIKit
import ObjectMapper

public class TimeMessage: RBSMessage {
    public var sec: Float64 = 0
    public var nsec: Float64 = 0
    
    override public func mapping(map: Map) {
        sec <- map["sec"]
        nsec <- map["nsec"]
    }
    
    public func date() -> Date {
        return Date(timeIntervalSinceReferenceDate: sec)
    }
}
