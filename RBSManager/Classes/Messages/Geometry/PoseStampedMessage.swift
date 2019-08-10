//
//  PoseStampedMessage.swift
//  RBSManager
//
//  Created by Wes Goodhoofd on 2019-08-07.
//

import UIKit
import ObjectMapper

public class PoseStampedMessage: RBSMessage {
    public var header: HeaderMessage?
    public var pose: PoseMessage?
    
    public override init() {
        super.init()
        header = HeaderMessage()
        pose = PoseMessage()
    }
    
    public required init?(map: Map) {
        super.init(map: map)
    }
    
    override public func mapping(map: Map) {
        header <- map["header"]
        pose <- map["pose"]
    }
}
