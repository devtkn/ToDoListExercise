//
//  ToDoViewController.swift
//  ToDoListExercise
//
//  Created by Thomas Krentz on 22/11/16.
//  Copyright © 2016 Thomas Krentz. All rights reserved.
//

import UIKit

class ToDoViewController: UIViewController,UITextFieldDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    var todoItem: TodoItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.delegate = self
        descriptionTextField.delegate = self
        if let todoItem = todoItem {
            navigationItem.title = todoItem.itemTitle
            titleTextField.text   = todoItem.itemTitle
            descriptionTextField.text = todoItem.itemDescription
        }
        else {
            todoItem = TodoItem(itemTitle: "", itemDescription: "")
            
        }
        // Set up views if editing an existing Meal.
        
        checkValidTitle()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
           let title = titleTextField.text
           let description = descriptionTextField.text
           todoItem = TodoItem(itemTitle: title!,itemDescription: description )
        }
    }
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddItemMode = presentingViewController is UINavigationController
        if isPresentingInAddItemMode {
            dismiss(animated: true, completion: nil)
        } else
        {
            navigationController!.popViewController(animated: true)

        }
        
    }
    
    // MARK: - Action
    
    
    
    // MARK: - TextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        //hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField){
        if textField === titleTextField{
            
            checkValidTitle()
            navigationItem.title = textField.text
            
            todoItem?.itemTitle = titleTextField.text!
        }
        if textField === descriptionTextField{
            todoItem?.itemDescription = descriptionTextField.text
        }
    
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        if textField === titleTextField{
            saveButton.isEnabled = false;
            todoItem?.itemTitle = titleTextField.text!
        }
        if textField === descriptionTextField{
            todoItem?.itemDescription = descriptionTextField.text
        }
        
    }
    
    // MARK: Helper-Functions
    func checkValidTitle() {
        // Disable the Save button if the text field is empty.
        let text = titleTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
