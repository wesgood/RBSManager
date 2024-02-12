//
//  BaseMessage.swift
//  Pods
//
//  Created by Wes Goodhoofd on 2018-01-06.
//

import Foundation
import ObjectMapper

open class RBSMessage: NSObject, Mappable {
    public var datePublished: Date?
    public var dateReceived: Date?

    public required init?(map: Map) {
        super.init()
        mapping(map: map)
    }

    public override init() {}

    open func mapping(map: Map) {
        // overridden
    }

    let base64Transform = TransformOf<[UInt8], String>(fromJSON: { (value: String?) -> [UInt8]? in
        // string -> array
        if value == nil {
            return nil
        }

        if let data = Data(base64Encoded: value!) {
            let array = [UInt8](data)
            return array
        } else {
            return nil
        }
    }, toJSON: { (value: [UInt8]?) -> String? in
        // base 64 to String
        if value == nil {
            return nil
        }
        return nil // unnecessary now
    })
}
