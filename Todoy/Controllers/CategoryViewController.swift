//
//  CategoryViewController.swift
//  Todoy
//
//  Created by Basma Said on 3/24/19.
//  Copyright © 2019 Basma Said. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()

    }
    
    
    //MARK: -TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
        
    }
    
    
    //MARK: -TableView Manipulation Methods
    
    func saveCategories() {
        
        do{
          try context.save()
        }catch{
            print("Error in Adding Actegories\(error)")
        }
        tableView.reloadData()
        
    }
    
    func loadCategories(){
        
    let request : NSFetchRequest<Category> = Category.fetchRequest()
        do{
           categories = try context.fetch(request)
        }catch{
            print("Error in fetch request\(error)")
        }
       tableView.reloadData()   
        
    }
    
    //MARK: -TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destiantonVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow{
           
              destiantonVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    //MARK: -Add New Categries

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Category", message: "Add New Categery", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in //action is the name of the action
            
            let newCtegory = Category(context: self.context)
            newCtegory.name = textField.text!
            self.categories.append(newCtegory)
            
           self.saveCategories()
            
            
        }
        
       alert.addAction(action)
        alert.addTextField { (field) in
            
            textField = field
            textField.placeholder = "Add new Categery"
        }
       
        present(alert, animated: true, completion: nil)
        
    }
    
   
    
}
