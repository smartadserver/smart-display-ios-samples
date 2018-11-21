//
//  MenuItem.swift
//  SwiftSample
//
//  Created by Julien Gomez on 25/10/2018.
//  Copyright © 2018 Smart AdServer. All rights reserved.
//

import Foundation

/*
 Represents an entry in the Main menu.
 */
class MenuItem: NSObject {
	
	let title: String
	let segueIdentifier: String
	
	init(title: String, segueIdentifier: String) {
		self.title = title
		self.segueIdentifier = segueIdentifier
		super.init()
	}
	
}
