//
//  AckermannDriveStamped.swift
//  RBSManager
//
//  Created by Brandon Man on 18/7/2019.
//

import UIKit
import ObjectMapper


public class AckermannDriveStampedMessage: RBSMessage {
    public var header: HeaderMessage?
    public var drive: AckermannDriveMessage?
    
    public override init() {
        super.init()
        header = HeaderMessage()
        drive = AckermannDriveMessage()
        
    }
    
    public required init?(map: Map) {
        super.init(map: map)
    }
    
    override public func mapping(map: Map) {
        header <- map["header"]
        drive <- map["drive"]
    }
}
