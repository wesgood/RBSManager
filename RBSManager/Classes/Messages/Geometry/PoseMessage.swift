//
//  PoseMessage.swift
//  RBSManager
//
//  Created by Wes Goodhoofd on 2019-08-07.
//

import UIKit
import ObjectMapper

public class PoseMessage: RBSMessage {
    public var position: PointMessage?
    public var orientation: QuaternionMessage?
    
    public override init() {
        super.init()
        position = PointMessage()
        orientation = QuaternionMessage()
    }
    
    public required init?(map: Map) {
        super.init(map: map)
    }
    
    override public func mapping(map: Map) {
        position <- map["position"]
        orientation <- map["orientation"]
    }
}
