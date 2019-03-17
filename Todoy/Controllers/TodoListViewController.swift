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
    
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist") //first mean because we are in array we are going to garb the first item
    

    //let defaults = UserDefaults() for defaults method
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadData()
        
     //Mark-defaults method used before
        
//        if let items = defaults.array(forKey: "toDoListArray") as? [Item] {
//            itemArray = items
//        }
//           use if condition to prevent carshing the app if the todo list doesn't excist
        //relaised that defaults it's not good way when we satart use class(customized objects) and it's perfect for small data store like on and off the volume because it's used plist file and to retrive this data need look in all the file which will take time
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
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true) //to remove the gray background
        
    }
    
    //Mark-Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "add new todo Item", message: "hello", preferredStyle: .alert)
        let action = UIAlertAction(title: "add Item", style: .default) { (action) in
            //the following that wt will happned when the user clicks on add Item Button
           
            
            //self.defaults.set(self.itemArray, forKey: "toDoListArray")//to save the data even after close the app and we can retrieve the data by the key name"toDoListArray" to be saved in plist file
           
            let newItem = Item()
            newItem.title = textField.text!
           self.itemArray.append(newItem)
            
            self.saveItems()
        }
            
        alert.addTextField { (alertTextField) in   //alert name is alertTextField
            
            alertTextField.placeholder = "creat new item" //the text apear in grey and dissapear when i strat typing
            
            textField = alertTextField
            
        }
        
        alert.addAction(action)
       present(alert,animated: true,completion: nil)
        
    }
    
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to:dataFilePath!)
        }catch{
            print("error encoding itemarray. \(error)")
        }
        self.tableView.reloadData()
    }
    
    
    func loadData(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding item Array \(error)")
            }
        }
        
        
    }
    
}


//Note
//Try ->  Requires a do-catch clause. Do-catch will provide a detailed error message if an error occurs.
//
//Try? -> Does not use a do-catch and only gives nil if there is an error.
//
//Try! -> Does not use a do-catch. Developer is confident that an error will not occur.
//
//With the above rules in mind, the first try in the sample code is written where the logic goes to the end of the function if an error occurs. No error message, just nil, would be provided if the datafilePath were missing or invalid.
//
//The second try is contained in a do-catch clause and gives a detailed error message.regarding any problem with parsing of the data.
//
//The choice of try statement depends on the kind of error trapping you need or want.


