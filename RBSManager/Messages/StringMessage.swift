//
//  StringMessage.swift
//  Pods
//
//  Created by Julian Gaal on 12.09.18.
//

import Foundation
import ObjectMapper

public class StringMessage: RBSMessage {
    public var data: String?

    override public func mapping(map: Map) {
        data <- map["data"]
    }
}
