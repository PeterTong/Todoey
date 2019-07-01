//
//  TodoListViewController.swift
//  Todoey
//
//  Created by KwokWing Tong on 2/6/2019.
//  Copyright © 2019 Tong Kwok Wing. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: SwipeTableViewController {
	
	var todoItems: Results<Item>?
	let realm = try! Realm()
	
	var selectedCategory: Category? {
		didSet{
			
			loadItems()
		}
	}
	
	

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
		
	}
	
	// MARK: TableView Datasource Methods
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return todoItems?.count ?? 1
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = super.tableView(tableView, cellForRowAt: indexPath)
		
		if let item = todoItems?[indexPath.row]{
			cell.textLabel?.text = item.title
			
			// Ternary operator ==>
			// value = condition ? valueIfTrue : valueIfFalse
			
			cell.accessoryType = item.done ? .checkmark : .none
		}else{
			cell.textLabel?.text = "No Items Added"
		}

		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		if let item = todoItems?[indexPath.row]{
			
			do{
				try realm.write {
					item.done = !item.done
				}
			}catch{
				print("Error saving done status, \(error)")
			}
		}
		
		tableView.reloadData()

//
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	// MARK: Add New Items

	@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
		
		var textField = UITextField()
		
		let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
		
		let action = UIAlertAction(title: "Add", style: .default) { (action) in
			// what will happen once the user clicks the Add Item button on our UIAlert
      
			
			if let currentCategory = self.selectedCategory{
				do{
					try self.realm.write {
						let newItem = Item()
						newItem.title = textField.text ?? "New Items"
						newItem.dateCreated = Date()
						currentCategory.items.append(newItem)
					}
				}catch{
					print("Error saving new items,\(error)")
				}
			}
			
			
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
	
	// MARK: Model Manupulation Methods
	
  // Item.fetchRequest() is default value
	func loadItems() {
		
		todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
		

//		let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//		if let additionPredicate = predicate{
//			request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionPredicate])
//		}else{
//			request.predicate = categoryPredicate
//		}
//
//
//    do{
//      itemArray = try context.fetch(request)
//
//    }catch{
//      print("Error Fetching data from context \(error)")
//    }
    tableView.reloadData()
  }
	
	override func updateModel(at indexPath: IndexPath) {
		
		if let item = self.todoItems?[indexPath.row]{
			do{
				try self.realm.write {
					self.realm.delete(item)
				}
			}catch{
				print("Error deleting item, \(error)")
			}
			
		}
		
	}
	
}

// MARK: - Search bar methods
extension TodoListViewController: UISearchBarDelegate{

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

		todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
		
		tableView.reloadData()

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

