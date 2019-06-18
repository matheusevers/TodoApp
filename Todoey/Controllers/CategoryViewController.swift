//
//  CategoryViewControllerTableViewController.swift
//  Todoey
//
//  Created by Matheus Evers Rodrigues Fernandes on 18/06/19.
//  Copyright © 2019 Matheus Evers. All rights reserved.
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
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
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
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    //MARK: - Data Manipulation Methods
    func saveCategories() {
        // Save data to CoreData
        do {
            try context.save()
        } catch {
            print("Error: \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories() {
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do{
            categories = try context.fetch(request)
        } catch {
            print("Error fetching data from context")
        }
        
        tableView.reloadData()
    }

    //MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var actionTextField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
                let newCategory = Category(context: self.context)
            
                newCategory.name = actionTextField.text!
            
                self.categories.append(newCategory)
            
                self.saveCategories()
        }
        
        alert.addAction(action)
        alert.addTextField { (textField) in
            textField.placeholder = "Add new category"
            
            actionTextField = textField
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    
}


