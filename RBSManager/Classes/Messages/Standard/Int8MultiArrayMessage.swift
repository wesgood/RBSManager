//
//  Int8MultiArrayMessage.swift
//  RBSManager
//
//  Created by Wes Goodhoofd on 2019-07-26.
//

import UIKit
import ObjectMapper

public class Int8MultiArrayMessage: RBSMessage {
    public var data: [UInt8]?
    public var layout: MultiArrayLayoutMessage?
    
    public override init() {
        super.init()
        layout = MultiArrayLayoutMessage()
    }
    
    public required init?(map: Map) {
        super.init(map: map)
    }
    
    override public func mapping(map: Map) {
        data <- (map["data"], base64Transform)
        layout <- map["layout"]
    }
}
