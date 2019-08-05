//
//  RBSResponse.swift
//  RBSManager
//
//  Created by Wes Goodhoofd on 2019-08-04.
//

import UIKit
import ObjectMapper

public enum ROSBridgeOperation: String {
    case publish = "publish"
    case serviceResponse = "service_response"
}
public class RBSResponse: NSObject, Mappable {
    public var service: String?
    public var topic: String?
    public var id: String?
    public var operation: ROSBridgeOperation?
    public var result: Int?
    public var values: Any?
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        service <- map["service"]
        topic <- map["topic"]
        id <- map["id"]
        operation <- map["op"]
        result <- map["result"]
        values <- map["values"]
    }
    
    public func getParameter() -> Any? {
        if let valuesObject = values as? [String : Any] {
            if let value = valuesObject["value"] {
                return value
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}
