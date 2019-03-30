//
//  ViewController.swift
//  Todoy
//
//  Created by Basma Said on 3/8/19.
//  Copyright © 2019 Basma Said. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController{


    var itemArray = [Item]()

    var selectedCategory : Category?{
        didSet{
            loadData()
        }
    }
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
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
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        
        
        
        return cell
        
    }
    //MARK: - tableView delegat Metods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        //itemArray[indexPath.row].setValue("completed", forKey: "title")
        //this method to update data
        

         itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)//those two lines are to delete item when click on the row and must be on that oreder delete from context first then remove fro the array

        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true) //to remove the gray background
        
    }
    
//MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "add new todo Item", message: "hello", preferredStyle: .alert)
        let action = UIAlertAction(title: "add Item", style: .default) { (action) in
            //the following that wt will happned when the user clicks on add Item Button
           
          
           
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
           newItem.parentCategory = self.selectedCategory
           self.itemArray.append(newItem)
            print("New Item = \(newItem)")
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
       
        do{
            try context.save()
        }catch{
           print("Error Saving context \(error)")
        }
        self.tableView.reloadData()
    }
    
    
    func loadData(with request: NSFetchRequest<Item> = Item.fetchRequest(),predicate:NSPredicate?=nil){  //method with input request use it internal and external use it with other name"with" just to makes sense as english reading in calling it
        // we gave the method insial value "Item.fetchRequest()" so if we call it without input so it will take the inisial as an input as in the viewdeadload part in the startup of the app
       
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@",   selectedCategory!.name!)
        
        if let addtionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [addtionalPredicate,categoryPredicate])
        }else{
            request.predicate = categoryPredicate
        }
        //the above lines:if the defaultc value of predicate not nil so go with the compined method
        
        
        do {
         itemArray = try context.fetch(request)
        }catch{
           print("Error Fetching data from context\(error)")
        }
        tableView.reloadData()
    }
}

//MARK: - SearchBar delegate Methods
    extension TodoListViewController: UISearchBarDelegate{ //extension for the viewcontroller calss to seperat it to parts
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS [cd] %@ ", searchBar.text!)
        
       request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        //to sort the result method, true mean sort in alphapetic order
        //sortDescriptors is puloral becouse the output is items of array
        
        loadData(with: request, predicate: predicate) //this line replaced with the follwoing lines
        
//        do {
//            itemArray = try context.fetch(request)
//        }catch{
//            print("Error Fetching data from context\(error)")
//        }
//        tableView.reloadData()
    }
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {   //delegat method triger when typing in the searchbar
            if searchBar.text!.count == 0 {  //the no of element =0
               loadData()
                DispatchQueue.main.async {
                    searchBar.resignFirstResponder()//this method to make the cursor and the keybard for search disappear which mean the search process not the main thread and dispatchqueue method dispatched as main thread
                    //so this method will be in the foreground
                }
                
               
               
            }
        }
    
    
    
}



