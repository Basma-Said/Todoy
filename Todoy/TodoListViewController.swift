//
//  ViewController.swift
//  Todoy
//
//  Created by Basma Said on 3/8/19.
//  Copyright © 2019 Basma Said. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray=["buy milk","buy egg","buy butter"]
    
    let defaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = defaults.array(forKey: "toDoListArray") as? [String] {
            itemArray = items
            
          //use if condition to prevent carshing the app if the todo list doesn't excist
        }
        
        
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
    
    //Mark-Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "add new todo Item", message: "hello", preferredStyle: .alert)
        let action = UIAlertAction(title: "add Item", style: .default) { (action) in
            //that wt will happned when the user clicks on add Item Button
            
            self.defaults.set(self.itemArray, forKey: "toDoListArray")//to save the data even after close the app and we can retrieve the data by the key name"toDoListArray" to be saved in plist file
            
           self.itemArray.append(textField.text!)
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in   //alert name is alertTextField
            alertTextField.placeholder = "creat new item" //the text apear in grey and dissapear when i strat typing
            textField = alertTextField
        }
        
        alert.addAction(action)
       present(alert,animated: true,completion: nil)
       
        
    }
    
    
}

