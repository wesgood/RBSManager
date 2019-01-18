//
//  CompressedImage.swift
//
//  Created by helming on 2019-01-18.
//

import UIKit
import ObjectMapper

public class CompressedImage: RBSMessage {
    public var header: Header = Header()
    public var format: String = ""
    public var data: [UInt8] = [UInt8]()
    
    
    public override func mapping(map: Map) {
        header <- map["header"]
        format <- map["format"]
        data <- map["data"]
    }
}
