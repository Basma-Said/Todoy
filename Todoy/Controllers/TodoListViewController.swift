//
//  ViewController.swift
//  Todoy
//
//  Created by Basma Said on 3/8/19.
//  Copyright © 2019 Basma Said. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController{


    var itemArray = [Item]()

    let defaults = UserDefaults()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem1 = Item()
        newItem1.title = "Find Milk"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Find bread"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Find egg"
        itemArray.append(newItem3)
        
        let newItem4 = Item()
        newItem4.title = "Find butter"
        itemArray.append(newItem4)
        
        let newItem5 = Item()
        newItem5.title = "Find Milk"
        itemArray.append(newItem5)
        
        let newItem6 = Item()
        newItem6.title = "Find bread"
        itemArray.append(newItem6)
        
//        let newItem7 = Item()
//        newItem7.title = "Find egg"
//        itemArray.append(newItem7)
//        
//        let newItem8 = Item()
//        newItem8.title = "Find butter"
//        itemArray.append(newItem8)
//        
//        let newItem9 = Item()
//        newItem9.title = "Find Milk"
//        itemArray.append(newItem9)
//        
//        let newItem10 = Item()
//        newItem10.title = "Find Milk"
//        itemArray.append(newItem10)
//        
//        let newItem11 = Item()
//        newItem11.title = "Find Milk"
//        itemArray.append(newItem11)
//        
//        
//        let newItem12 = Item()
//        newItem12.title = "Find bread"
//        itemArray.append(newItem12)
//        
//        let newItem13 = Item()
//        newItem13.title = "Find egg"
//        itemArray.append(newItem13)
//        
//        let newItem14 = Item()
//        newItem14.title = "Find butter"
//        itemArray.append(newItem14)
//        
//        let newItem15 = Item()
//        newItem15.title = "Find Milk"
//        itemArray.append(newItem15)
//        
//        let newItem16 = Item()
//        newItem16.title = "Find Milk"
//        itemArray.append(newItem16)
//        
//        let newItem17 = Item()
//        newItem17.title = "Find Milk"
//        itemArray.append(newItem17)
//        
//        let newItem18 = Item()
//        newItem18.title = "Find Milk"
//        itemArray.append(newItem18)
//        
//        let newItem19 = Item()
//        newItem19.title = "Find Milk"
//        itemArray.append(newItem19)
//        
//        let newItem20 = Item()
//        newItem20.title = "Find Milk"
//        itemArray.append(newItem20)
//        
//        

       
        if let items = defaults.array(forKey: "toDoListArray") as? [Item] {
            itemArray = items
        }
         //  use if condition to prevent carshing the app if the todo list doesn't excist
        }
        
        
    
    //Mark-tableView DataSource Method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        
        //Ternary  operator
        // value = condition ? .checkmark : .none
        
        cell.accessoryType = item.done ? .checkmark : .none
        
//the above line is equivalets to the follwing lines
//        if itemArray[indexPath.row].done == true {
//            cell.accessoryType = .checkmark
//        }else{
//            cell.accessoryType = .none
//        }
        
        
        
        //this data source method gets tergir only when the app loaded first time so the change in check mark will not appear so to trigger this method again have to use reload data method in delegate part
        
        return cell
        
    }
    //Mark-tableView delegat Metods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
         itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
      tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true) //to remove the gray background
        
    }
    
    //Mark-Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "add new todo Item", message: "hello", preferredStyle: .alert)
        let action = UIAlertAction(title: "add Item", style: .default) { (action) in
            //that wt will happned when the user clicks on add Item Button
            
            self.defaults.set(self.itemArray, forKey: "toDoListArray")//to save the data even after close the app and we can retrieve the data by the key name"toDoListArray" to be saved in plist file
           let newItem = Item()
            newItem.title = textField.text!
           self.itemArray.append(newItem)
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

