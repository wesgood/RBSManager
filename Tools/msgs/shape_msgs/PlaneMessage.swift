//
//  PlaneMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class PlaneMessage: RBSMessage {
	public var coef: float64[4] = [float64[4]]()
    

    public override func mapping(map: Map) {
	    coef <- map["coef"]
    }
}
