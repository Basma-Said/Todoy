//
//  ViewController.swift
//  Todoy
//
//  Created by Basma Said on 3/8/19.
//  Copyright © 2019 Basma Said. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let itemArray=["buy milk","buy egg","buy butter"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    //Mark-tableView DataSource Method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
        
    }
    //Mark-tableView delegat Metods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true) //to remove the gray background
        
    }
    
    
    
    
}

