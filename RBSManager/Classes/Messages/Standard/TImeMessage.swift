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

    public override init() {
        super.init()
    }
    
    public required init?(map: Map) {
        super.init(map: map)
    }
    
    override public func mapping(map: Map) {
        sec <- map["secs"]
        nsec <- map["nsecs"]
    }
    
    public func date() -> Date {
        return Date(timeIntervalSinceReferenceDate: sec)
    }
}
