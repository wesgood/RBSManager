//
//  InteractiveMarkerMessage.swift
//
//  Created by wesgoodhoofd on 2019-01-22.
//

import UIKit
import ObjectMapper

public class InteractiveMarkerMessage: RBSMessage {
	public var header: HeaderMessage?
	public var pose: PoseMessage?
	public var name: string
	public var description: string
	public var scale: float32 = 0
	public var menu_entries: MenuEntryMessage[]? = [MenuEntryMessage[]]()
	public var controls: InteractiveMarkerControlMessage[]? = [InteractiveMarkerControlMessage[]]()
    
	public override init() {
		super.init()
		header = HeaderMessage()
	pose = PoseMessage()
	menu_entries = MenuEntryMessage[]()
	controls = InteractiveMarkerControlMessage[]()
	}
	public required init?(map: Map) {
		super.init(map: map)
	}

    public override func mapping(map: Map) {
	    header <- map["header"]
		pose <- map["pose"]
		name <- map["name"]
		description <- map["description"]
		scale <- map["scale"]
		menu_entries <- map["menu_entries"]
		controls <- map["controls"]
    }
}
