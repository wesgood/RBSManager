//
//  GeoPoseMessage.swift
//  RBSManager
//
//  Created by Wes Goodhoofd on 2020-08-16.
//

import UIKit
import ObjectMapper

public class GeoPoseMessage: RBSMessage {
    public var position: GeoPointMessage?
    public var orientation: QuaternionMessage?
    
    public override init() {
        super.init()
        position = GeoPointMessage()
        orientation = QuaternionMessage()
    }
    
    public required init?(map: Map) {
        super.init(map: map)
    }
    
    public override func mapping(map: Map) {
        position <- map["position"]
        orientation <- map["orientation"]
    }
}
