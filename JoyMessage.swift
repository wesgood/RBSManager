//
//  JoyMessage.swift
//  RBSManager
//
//  Created by Brandon Man on 22/7/2019.
//

import UIKit
import ObjectMapper

public class JoyMessage: RBSMessage {
    public var axes: Array = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    public var buttons: Array = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    
    public override func mapping(map: Map) {
        axes <- map["axes"]
        buttons <- map["buttons"]
    }
    
}
