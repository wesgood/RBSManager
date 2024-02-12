//
//  Float32Message.swift
//
//  Created by wesgoodhoofd on 2018-09-19.
//

import Foundation
import ObjectMapper

public class Float32Message: RBSMessage {
    public var data: Float32 = 0

    public override func mapping(map: Map) {
        data <- map["data"]
    }
}
