//
//  BaseMessage.swift
//  Pods
//
//  Created by Wes Goodhoofd on 2018-01-06.
//

import UIKit
import ObjectMapper

public class RBSMessage: NSObject, Mappable {
    var datePublished: Date?
    var dateReceived: Date?
    
    required public init?(map: Map) {
        super.init()
        mapping(map: map)
    }
    
    public func mapping(map: Map) {
        // overridden
    }
}
