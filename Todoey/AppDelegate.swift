//
//  AppDelegate.swift
//  Todoey
//
//  Created by KwokWing Tong on 2/6/2019.
//  Copyright © 2019 Tong Kwok Wing. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		
		// MARK: - Migration code from realm(https://realm.io/docs/swift/latest/#migrations)
//		Realm.Configuration.defaultConfiguration = Realm.Configuration(
//			schemaVersion: 1,
//			migrationBlock: { migration, oldSchemaVersion in
//				if (oldSchemaVersion < 1) {
//					// The enumerateObjects(ofType:_:) method iterates
//					// over every Person object stored in the Realm file
//					migration.enumerateObjects(ofType: Item.className()) { oldObject, newObject in
//						// combine name fields into a single field
//						let firstName = oldObject!["firstName"] as! String
//						let lastName = oldObject!["lastName"] as! String
//						newObject!["fullName"] = "\(firstName) \(lastName)"
//					}
//				}
//		})
//		print(Realm.Configuration.defaultConfiguration.fileURL)
		
		do {
			_ = try Realm()
		} catch  {
			print("Error initialising new realm, \(error)")
		}
		
		return true
	}


	func applicationWillTerminate(_ application: UIApplication) {
		
	}
	
	


}

