//
//  DiagnosticArrayMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class DiagnosticArrayMessage: RBSMessage {
	public var header: HeaderMessage?
	public var status: DiagnosticStatusMessage[]? = [DiagnosticStatusMessage[]]()
    
	public override init() {
		super.init()
		header = HeaderMessage()
	status = DiagnosticStatusMessage[]()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    header <- map["header"]
		status <- map["status"]
    }
}
