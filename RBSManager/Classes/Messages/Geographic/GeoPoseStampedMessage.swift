//
//  GeoPoseStampedMessage.swift
//  RBSManager
//
//  Created by Wes Goodhoofd on 2020-08-16.
//

import UIKit
import ObjectMapper

public class GeoPoseStampedMessage: RBSMessage {
    public var header: HeaderMessage?
    public var pose: GeoPoseMessage?
    
    public override init() {
        super.init()
        header = HeaderMessage()
        pose = GeoPoseMessage()
    }
    
    public required init?(map: Map) {
        super.init(map: map)
    }
    
    public override func mapping(map: Map) {
        header <- map["header"]
        pose <- map["pose"]
    }
}
