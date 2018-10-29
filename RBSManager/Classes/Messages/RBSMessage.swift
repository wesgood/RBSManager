//
//  BaseMessage.swift
//  Pods
//
//  Created by Wes Goodhoofd on 2018-01-06.
//

import UIKit
import ObjectMapper

open class RBSMessage: NSObject, Mappable {
    public var datePublished: Date?
    public var dateReceived: Date?
    
    public required init?(map: Map) {
        super.init()
        mapping(map: map)
    }
    
    public override init() {}
    
    open func mapping(map: Map) {
        // overridden
    }
}
