//
//  PathMessage.swift
//  RBSManager
//
//  Created by Wes Goodhoofd on 2019-08-07.
//

import UIKit
import ObjectMapper

public class PathMessage: RBSMessage {
    public var header: HeaderMessage?
    public var poses: [PoseStampedMessage]?
    
    public override init() {
        super.init()
        header = HeaderMessage()
        poses = [PoseStampedMessage]()
    }
    
    public required init?(map: Map) {
        super.init(map: map)
    }
    
    override public func mapping(map: Map) {
        header <- map["header"]
        poses <- map["poses"]
    }
}
