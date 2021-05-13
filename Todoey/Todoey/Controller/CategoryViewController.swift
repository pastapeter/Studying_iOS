//
//  CategoryViewController.swift
//  Todoey
//
//  Created by abc on 2021/05/13.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var CategoryArray = [TodoCategory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CategoryArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = CategoryArray[indexPath.row]
        cell.textLabel?.text = category.name
        
        return cell
    }
    
    //MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = CategoryArray[indexPath.row]
        }
    }
    
    //MARK: - Data Manipulate methods
    // CRUD
    func loadCategory(with request: NSFetchRequest<TodoCategory> = TodoCategory.fetchRequest()){
        do {
            CategoryArray = try context.fetch(request)
        } catch {
            print("ERROR fetching data from context \(error)")
        }
        tableView.reloadData()
    }
    
    func saveCategory(){
        do {
            try context.save()
        } catch  {
            print("ERROR saving context \(error)")
        }
       
         self.tableView.reloadData()
    }
    
    //MARK: - Add new Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            let newCategory = TodoCategory(context: self.context)
            newCategory.name = textfield.text!
            self.CategoryArray.append(newCategory)
            self.saveCategory()
        }
        alert.addTextField { (alerttextfield) in
            alerttextfield.placeholder = "Add Category"
            textfield = alerttextfield
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
   


    
}
