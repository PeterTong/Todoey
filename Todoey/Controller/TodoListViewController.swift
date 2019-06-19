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
	let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
	

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		print(dataFilePath)
		

		
		loadItems()
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
		
		self.saveItems()
		
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
			
			self.saveItems()
			
		}
		
		alert.addTextField { (alertTextField) in
			alertTextField.placeholder = "Create new item"
			// store a reference to that alerttextfield inside a local variable
			textField = alertTextField
			
			
		}
		
		alert.addAction(action)
		
		present(alert, animated: true, completion: nil)
	}
	
	// MARK: Model Manupulation Methods
	func saveItems() {
		
		let encoder = PropertyListEncoder()
		do{
			let data = try encoder.encode(self.itemArray)
			try data.write(to: self.dataFilePath!)
			
		}catch{
			print("Error encoding item array, \(error)")
		}
		
		
		self.tableView.reloadData()
	}
	
	func loadItems() {
		
		if let data = try? Data(contentsOf: dataFilePath!){
			let decoder = PropertyListDecoder()
			
			do{
				itemArray = try decoder.decode([Item].self, from: data)
			}catch{
				
			}
			
		}
	}
	
}

