//
//  MeshMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class MeshMessage: RBSMessage {
	public var triangles: MeshTriangleMessage[]? = [MeshTriangleMessage[]]()
	public var vertices: PointMessage[]? = [PointMessage[]]()
    
	public override init() {
		super.init()
		triangles = MeshTriangleMessage[]()
	vertices = PointMessage[]()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    triangles <- map["triangles"]
		vertices <- map["vertices"]
    }
}
