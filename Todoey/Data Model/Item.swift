//
//  Item.swift
//  Todoey
//
//  Created by KwokWing Tong on 16/6/2019.
//  Copyright © 2019 Tong Kwok Wing. All rights reserved.
//

import UIKit

class Item: Codable {
	
	// Conform the Encodable protocol, all of its properties must have standard data types
	
	var title: String = ""
	var done: Bool = false

}
