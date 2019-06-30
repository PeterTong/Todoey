//
//  Category.swift
//  Todoey
//
//  Created by KwokWing Tong on 29/6/2019.
//  Copyright © 2019 Tong Kwok Wing. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
	@objc dynamic var name: String = ""
	let items = List<Item>()
//	let array: Array<Int> = [1,2,3]
}
