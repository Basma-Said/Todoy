//
//  ViewController.swift
//  Todoy
//
//  Created by Basma Said on 3/8/19.
//  Copyright © 2019 Basma Said. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController{


    var todoItems: Results<Item>?
    let realm = try! Realm()
    var selectedCategory : Category?{
        didSet{
          loadData()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationItem.leftItemsSupplementBackButton = true
        //code to get back button appear but didn't work with me
        
         print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
       //searchBar.delegate = self //to set the statuse bar for this viewcontroller or we can set by drag while pressing ctrl button it in the main stroyBord to the yellow circle in the bar of the controller as i did here
        //or from the decoument outline drag the name of searchbar to the yellow circle
        
      
        
       
        
    
    }
    
//MARK - tableView DataSource Method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            
            cell.accessoryType = item.done ? .checkmark : .none
        }else{
            cell.textLabel?.text = "No Items Added"
        }
        
        
        
        return cell
        
    }
    //MARK: - tableView delegat Metods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row]{
            do{
                try realm.write{
                    
                    //realm.delete(item)code  to delete data in realm
                    item.done = !item.done
                }
            }catch{
                print("Error in updating data\(error)")
            }
        }

        //itemArray[indexPath.row].setValue("completed", forKey: "title")
        //this method to update data
        

//         todoItems?[indexPath.row].done = !todoItems[indexPath.row].done
//
//        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true) //to remove the gray background
        tableView.reloadData()
    }
    
//MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "add new todo Item", message: "hello", preferredStyle: .alert)
        let action = UIAlertAction(title: "add Item", style: .default) { (action) in
            //the following that wt will happned when the user clicks on add Item Button
            
            if let currentCategory = self.selectedCategory {
            do{
                try self.realm.write {
                    
                    let newItem = Item()
                    newItem.title = textField.text!
                    newItem.dateCreated = Date()
                    currentCategory.items.append(newItem)
            }
            
            }catch{
                print("Error in saving data\(error)")
                }
            }
           self.tableView.reloadData()
        }
            
        alert.addTextField { (alertTextField) in   //alert name is alertTextField
            
            alertTextField.placeholder = "creat new item" //the text apear in grey and dissapear when i strat typing
            
            textField = alertTextField
            
        }
        
        alert.addAction(action)
       present(alert,animated: true,completion: nil)
        
    }
    
    
    
    func loadData(){
        
       todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

        tableView.reloadData()
    }

}

//MARK: -searchbar method

extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
        
        }
        
       
    
    
}
