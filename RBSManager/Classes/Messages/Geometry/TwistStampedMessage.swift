//
//  TwistStampedMessage.swift
//  Pods
//
//  Created by Jason Pack on 2018-11-13.
//

import UIKit
import ObjectMapper

public class TwistStampedMessage: RBSMessage {
    public var header: HeaderMessage?
    public var twist: TwistMessage?
    
    public override init() {
        super.init()
        header = HeaderMessage()
        twist = TwistMessage()
    }
    
    public required init?(map: Map) {
        super.init(map: map)
    }
    
    override public func mapping(map: Map) {
        header <- map["header"]
        twist <- map["twist"]
    }
}
