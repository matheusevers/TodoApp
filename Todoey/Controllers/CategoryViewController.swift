//
//  CategoryViewControllerTableViewController.swift
//  Todoey
//
//  Created by Matheus Evers Rodrigues Fernandes on 18/06/19.
//  Copyright © 2019 Matheus Evers. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()

    var categories : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
    }
    
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories added yet"
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row] 
        }
    }
    
    //MARK: - Data Manipulation Methods
    func save(category : Category) {
        // Save data to CoreData
        do {
            try realm.write {
                    realm.add(category)
            }
        } catch {
            print("Error: \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories() {
       
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
    }

    //MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var actionTextField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
                let newCategory = Category()
            
                newCategory.name = actionTextField.text!
            
                self.save(category: newCategory)
        }
        
        alert.addAction(action)
        alert.addTextField { (textField) in
            textField.placeholder = "Add new category"
            
            actionTextField = textField
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    
}


