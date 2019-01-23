//
//  MeshTriangleMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class MeshTriangleMessage: RBSMessage {
	public var vertex_indices: uint32[3] = [uint32[3]]()
    

    public override func mapping(map: Map) {
	    vertex_indices <- map["vertex_indices"]
    }
}
