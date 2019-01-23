//
//  GridCellsMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class GridCellsMessage: RBSMessage {
	public var header: HeaderMessage?
	public var cell_width: float32 = 0
	public var cell_height: float32 = 0
	public var cells: PointMessage[]? = [PointMessage[]]()
    
	public override init() {
		super.init()
		header = HeaderMessage()
	cells = PointMessage[]()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    header <- map["header"]
		cell_width <- map["cell_width"]
		cell_height <- map["cell_height"]
		cells <- map["cells"]
    }
}
