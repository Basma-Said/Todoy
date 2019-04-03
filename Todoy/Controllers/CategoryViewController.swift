//
//  CategoryViewController.swift
//  Todoy
//
//  Created by Basma Said on 3/24/19.
//  Copyright © 2019 Basma Said. All rights reserved.
//

import UIKit
import RealmSwift

    let realm = try! Realm()

class CategoryViewController: UITableViewController {
    
    var categories: Results<Category>? //result is an auto updating container
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       loadCategories()

    }
    
    
    //MARK: -TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
        //that line if code mean if categories is not nill the return categories.count an if it is nill (??, call in swift nil coalescing operator) so return 1
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categries added yet"
        
        return cell
        
    }
    
    
    //MARK: -TableView Manipulation Methods
    
    func save(category: Category) {
        
        do{
            try realm.write{
                realm.add(category)
            }
        }catch{
            print("Error in Adding Actegories\(error)")
        }
        tableView.reloadData()
        
    }
    
      func loadCategories(){

     categories = realm.objects(Category.self)
        
        
        
       tableView.reloadData()

    }
    
    //MARK: -TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destiantonVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow{
           
              destiantonVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    //MARK: -Add New Categries

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Category", message: "Add New Categery", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in //action is the name of the action
            
            let newCategory = Category()
            newCategory.name = textField.text!
           
           self.save(category: newCategory)
            
            
        }
        
       alert.addAction(action)
        alert.addTextField { (field) in
            
            textField = field
            textField.placeholder = "Add new Categery"
        }
       
        present(alert, animated: true, completion: nil)
        
    }
    
   
    
}
