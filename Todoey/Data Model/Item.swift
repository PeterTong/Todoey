//
//  Data.swift
//  Todoey
//
//  Created by KwokWing Tong on 28/6/2019.
//  Copyright © 2019 Tong Kwok Wing. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
	
	// dynamic is called a declaration modifier. It basically tells the
	// runtime to use dynamic dispatch over the standard which is a static dispatch
	// this basically allows this property name to be monitored for change at runtime
	// dynamic dispatch comed for the objective C API
	@objc dynamic var title: String = ""
	@objc dynamic var done: Bool = false
	@objc dynamic var dateCreated: Date?
	var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
	
	
}
