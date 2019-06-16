//
//  TodoListViewController.swift
//  Todoey
//
//  Created by KwokWing Tong on 2/6/2019.
//  Copyright © 2019 Tong Kwok Wing. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
	
	var itemArray = [Item]()
	
	var defaults = UserDefaults.standard

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
//		if let item = defaults.array(forKey: "TodoListArray") as? [String] {
//			itemArray = item
//		}
		
		let newItem = Item()
		newItem.title = "Find Mike"
		newItem.done = true
		itemArray.append(newItem)
		
		
		let newItem2 = Item()
		newItem2.title = "Buy Eggs"
		itemArray.append(newItem2)
		
		let newItem3 = Item()
		newItem3.title = "Destory Demogorgon"
		itemArray.append(newItem3)
	}
	
	// MARK: TableView Datasource Methods
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return itemArray.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
		
		let item = itemArray[indexPath.row]
		
		cell.textLabel?.text = item.title
		
		// Ternary operator ==>
		// value = condition ? valueIfTrue : valueIfFalse
		
		cell.accessoryType = item.done ? .checkmark : .none
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//		print(itemArray[indexPath.row])
		
		itemArray[indexPath.row].done = !itemArray[indexPath.row].done
		
		tableView.reloadData()
		
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	// MARK: Add New Items

	@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
		
		var textField = UITextField()
		
		let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
		
		let action = UIAlertAction(title: "Add", style: .default) { (action) in
			// what will happen once the user clicks the Add Item button on our UIAlert
			let newItem = Item()
			newItem.title = textField.text ?? "New Items"
			
			self.itemArray.append(newItem)
			
			self.defaults.set(self.itemArray, forKey: "TodoListArray")
			self.tableView.reloadData()
		}
		
		alert.addTextField { (alertTextField) in
			alertTextField.placeholder = "Create new item"
			// store a reference to that alerttextfield inside a local variable
			textField = alertTextField
			
			
		}
		
		alert.addAction(action)
		
		present(alert, animated: true, completion: nil)
	}
	
}

