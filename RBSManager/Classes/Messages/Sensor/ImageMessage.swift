//
//  ImageMessage.swift
//  RBSManager
//
//  Created by Wes Goodhoofd on 2020-05-11.
//

import UIKit
import ObjectMapper

public class ImageMessage: RBSMessage {
    public var header: HeaderMessage?
    public var height: UInt32?
    public var width: UInt32?
    public var encoding: String?
    public var isBigendian: UInt8?
    public var step: UInt32?
    public var data: [UInt8]?
    public var encodedData: String?
    
    public override init() {
        super.init()
        header = HeaderMessage()
    }
    
    public required init?(map: Map) {
        super.init(map: map)
    }
    
    public override func mapping(map: Map) {
        header <- map["header"]
        height <- map["height"]
        width <- map["width"]
        encoding <- map["encoding"]
        isBigendian <- map["is_bigendian"]
        step <- map["step"]
        data <- map["data"]
        encodedData <- map["data"]
    }
}
