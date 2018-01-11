//
//  BaseMessage.swift
//  Pods
//
//  Created by Wes Goodhoofd on 2018-01-06.
//

import UIKit
import ObjectMapper

public class RBSMessage: NSObject, Mappable {
    public var datePublished: Date?
    public var dateReceived: Date?
    
    public required init?(map: Map) {
        super.init()
        mapping(map: map)
    }
    
    public override init() {}
    
    public func mapping(map: Map) {
        // overridden
    }
}
