//
//  GeoPointMessage.swift
//  RBSManager
//
//  Created by Wes Goodhoofd on 2020-08-16.
//

import UIKit
import ObjectMapper

public class GeoPointMessage: RBSMessage {
    public var latitude: Float64 = 0
    public var longitude: Float64 = 0
    
    public override func mapping(map: Map) {
        latitude <- map["latitude"]
        longitude <- map["longitude"]
    }
}
