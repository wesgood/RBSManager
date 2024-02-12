//
//  PathMessage.swift
//  RBSManager
//
//  Created by Wes Goodhoofd on 2019-08-07.
//

import Foundation
import ObjectMapper

public class PathMessage: RBSMessage {
    public var header: HeaderMessage?
    public var poses: [GeoPoseStampedMessage]?

    public override init() {
        super.init()
        header = HeaderMessage()
        poses = [GeoPoseStampedMessage]()
    }

    public required init?(map: Map) {
        super.init(map: map)
    }

    override public func mapping(map: Map) {
        header <- map["header"]
        poses <- map["poses"]
    }
}
