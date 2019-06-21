//
//  TodoListViewController.swift
//  Todoey
//
//  Created by KwokWing Tong on 2/6/2019.
//  Copyright © 2019 Tong Kwok Wing. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
	
	var itemArray = [Item]()
	
	let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    
    
  
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
    
    context.delete(itemArray[indexPath.row])
    itemArray.remove(at: indexPath.row)
		
//    itemArray[indexPath.row].done = !itemArray[indexPath.row].done
		
		self.saveItems()
		
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	// MARK: Add New Items

	@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
		
		var textField = UITextField()
		
		let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
		
		let action = UIAlertAction(title: "Add", style: .default) { (action) in
			// what will happen once the user clicks the Add Item button on our UIAlert
      
      
      let newItem = Item(context: self.context)
			newItem.title = textField.text ?? "New Items"
			newItem.done = false
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
		
		
		do{
      try context.save()
			
		}catch{
			print("Error saving context \(error)")
		}
		
		
		self.tableView.reloadData()
	}
	
  // Item.fetchRequest() is default value
  func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
    
    do{
      itemArray = try context.fetch(request)
      
    }catch{
      print("Error Fetching data from context \(error)")
    }
    tableView.reloadData()
  }
  
}

// MARK: - Search bar methods
extension TodoListViewController: UISearchBarDelegate{
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
    let request: NSFetchRequest<Item> = Item.fetchRequest()
    
    request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
    
    request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
    

    loadItems(with: request)
    
    
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchBar.text?.count == 0 {
      loadItems()
      
      DispatchQueue.main.async {
        searchBar.resignFirstResponder()
      }
      
      
    }
  }
  
  
  
  
  
  
}

