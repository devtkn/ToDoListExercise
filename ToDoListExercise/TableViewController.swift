//
//  ViewController.swift
//  ToDoListExercise
//
//  Created by Thomas Krentz on 20/11/16.
//  Copyright © 2016 Thomas Krentz. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    var todoItem: TodoItem?
    
    var todoItems = [TodoItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //  navigationItem.rightBarButtonItem = editButtonItem
        
        automaticallyAdjustsScrollViewInsets = false
        loadItems()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
       
        if self.tableView.isEditing {
            editButton.title = "Edit"
            self.tableView.setEditing(false, animated: true)
        } else {
            editButton.title = "Done"
            self.tableView.setEditing(true, animated: true)
        }
    }
    //MARK: DataSource Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! ToDoItemTableViewCell
        let item = todoItems[indexPath.row]
        
        cell.titelLabel.text = item.itemTitle
        cell.descriptionLabel.text = item.itemDescription
        
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todoItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        if editing {
            tableView.setEditing(true, animated: true)
        } else {
            tableView.setEditing(false, animated: true)
        }
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowDetail" {
            let itemDetailController = segue.destination as! ToDoViewController
            if let selectedItemCell = sender as? ToDoItemTableViewCell {
                let indexPath = tableView.indexPath(for: selectedItemCell)
                let selectedItem = todoItems[(indexPath?.row)!]
                itemDetailController.todoItem = selectedItem
            
            }
        }
        else if segue.identifier == "AddItem" {
            print("Adding new item.")
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row >= todoItems.count && isEditing {
            return false
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        if destinationIndexPath.row != sourceIndexPath.row {
                swap(&todoItems[destinationIndexPath.row], &todoItems[sourceIndexPath.row])
            
        }
    }
    
    
    // MARK: Action 
    
    @IBAction func unwindToTableView(sender: UIStoryboardSegue) {
        if let source = sender.source as? ToDoViewController, let todoItem = source.todoItem {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing item.
                todoItems[selectedIndexPath.row] = todoItem
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                // Add a new item.
                let newIndexPath = IndexPath(row: todoItems.count, section: 0)
                todoItems.append(todoItem)
                tableView.insertRows(at: [newIndexPath as IndexPath], with: .bottom)
            }
        }
    }
    
    //MARK: Helper-Functions
    
    func loadItems(){
        let todoItem1 = TodoItem(itemTitle: "Shopping",itemDescription: "Buy vegetables")
        todoItems.append(todoItem1)
        let todoItem2 = TodoItem(itemTitle: "Carwash",itemDescription: "Wash the cabrio")
        todoItems.append(todoItem2)
    }
    
    


}

