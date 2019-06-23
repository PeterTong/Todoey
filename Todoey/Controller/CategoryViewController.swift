//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Tong Kwok Wing on 21/6/2019.
//  Copyright © 2019 Tong Kwok Wing. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
	
	var categories = [Category]()
	
	
	let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

	override func viewDidLoad() {
		super.viewDidLoad()
		
		
	}
	
	// MARK: - TableView Datasource Methods
	
	// MARK: - Data Manipulation Methods
	
	// MARK: - Add New Categories
	
	@IBAction func addButtonItem(_ sender: UIBarButtonItem) {
		
		
	}
	
	
	
	// MARK: - TableView Delegate Methods
	
	
	
	
	
	
	
	
}
