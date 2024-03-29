//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by KwokWing Tong on 1/7/2019.
//  Copyright © 2019 Tong Kwok Wing. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
				
        tableView.rowHeight = 80.0
    }
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
		
		cell.delegate = self
		
		return cell
	}

	func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
		
		guard orientation == .right else { return nil }
		
		let deleteAction = SwipeAction(style: .destructive, title: "Delete") { (action, indexPath) in
			print("Item delete")
			
			self.updateModel(at: indexPath)
		}
		
		// customize the action appearance
		deleteAction.image = UIImage(named: "delete-icon")
		return [deleteAction]
		
	}
	
	
	func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
		
		var options = SwipeTableOptions()
		options.expansionStyle = .destructive
		options.transitionStyle = .border
		return options
	}
	
	func updateModel(at indexPath: IndexPath){
		// update our data model
		print("Item delete from superclass")
	}
	

}


