//
//  RBSResponse.swift
//  RBSManager
//
//  Created by Wes Goodhoofd on 2019-08-04.
//

import Foundation
import ObjectMapper

public enum ROSBridgeOperation: String {
    case publish = "publish"
    case serviceResponse = "service_response"
}
public class RBSResponse: NSObject, Mappable {
    public var service: String?
    public var topic: String?
    public var responseId: String?
    public var operation: ROSBridgeOperation?
    public var result: Int?
    public var values: Any?
    public var message: [String: Any]?

    required public init?(map: Map) {
    }

    public func mapping(map: Map) {
        service <- map["service"]
        topic <- map["topic"]
        responseId <- map["id"]
        operation <- map["op"]
        result <- map["result"]
        values <- map["values"]
        message <- map["msg"]
    }

    public func getFloatParameter() -> Float? {
        if let valuesObject = values as? [String: Any] {
            if let value = valuesObject["value"] as? NSString, value.lowercased != "null" {
                return value.floatValue
            } else {
                return nil
            }
        } else {
            return nil
        }
    }

    public func getStringParameter() -> String? {
        if let valuesObject = values as? [String: Any] {
            if let value = valuesObject["value"] as? String {
                return value
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}
