//
//  ExercisesTableViewController.swift
//  Training Log Plus
//
//  Created by Elliott, Josh on 9/29/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit
import CoreData

class Exercises_TVC: UITableViewController {

    var bodyPartData: [String] = []
    //var exerciseData: [String] = []
    var exerciseData: [Exercise] = []
    
    var selectedBodyPart: String?
    var selectedExercise: String?
    
    var bodyPartPicker = UIPickerView()
    var exercisePicker = UIPickerView()
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var bodyPartTextField: UITextField!
    @IBOutlet weak var exerciseTextField: UITextField!
    
    @IBAction func createButton(_ sender: UIBarButtonItem) {
        clearButtonFunction()
        createButtonFunc()
        print("first spot")
    }
    @IBAction func clearButton(_ sender: UIBarButtonItem) {
        clearButtonFunction()
    }
    
    
    /*
     * View Did Load
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Test VDL")
        
        bodyPartData = Util.getGenericBodyPartData()
        
        // Will have to figure how to fill this AFTER bodypart picker is selected
//        let request = Exercise.fetchRequest() as NSFetchRequest<Exercise>
//
//        do {
//            exerciseData = try context.fetch(request)
//        } catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//        }
        
        //exerciseData = Util.getGenericExerciseData()
        
        createPickers()
        createToolbarDoneButton()
    }
    
//    private func refresh() {
//
//        let request = Friend.fetchRequest() as NSFetchRequest<Friend>
//
//        if !query.isEmpty {
//            request.predicate = NSPredicate(format: "name CONTAINS[cd] %@", query)
//        }
//
//        //let sort = NSSortDescriptor(keyPath: \Friend.name, ascending: true)
//        let sort = NSSortDescriptor(key: #keyPath(Friend.name), ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))
//        request.sortDescriptors = [sort]
//
//
//        do {
//            friends = try context.fetch(request)
//        } catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//        }
//    }
    

    /*
     * Create Button Function
     *
     * Adds data to database
     */
    func createButtonFunc() {
        // Add item to data here
        print("2 spot")
        selectedBodyPart = bodyPartTextField.text
        bodyPartTextField.text = ""
        selectedExercise = exerciseTextField.text
        exerciseTextField.text = ""
        print("3 spot")
    }
    
    
    /*
     * Clear Button Function
     *
     * Clears the data from all the textfields
     */
    func clearButtonFunction() {
        Util.clearTextField(bodyPartTextField)
        Util.clearTextField(exerciseTextField)
    }
    
    
    /*
     * Create Pickers
     *
     * Creates the pickers for the text fields
     */
    func createPickers() {
        
        bodyPartPicker.delegate = self
        exercisePicker.delegate = self
        
        bodyPartTextField.inputView = bodyPartPicker
        exerciseTextField.inputView = exercisePicker
    }
    
    
    /*
     * Create Tool Bar Done Button
     *
     * Creates done buttons for the toolbars
     */
    func createToolbarDoneButton() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonAction))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        bodyPartTextField.inputAccessoryView = toolBar
        exerciseTextField.inputAccessoryView = toolBar
    }
    
    
    /*
     * Done Button Action
     *
     * Tells the toolbar what to do when done is tapped
     */
    @objc func doneButtonAction() {
        if bodyPartTextField.isEditing {
            bodyPartTextField.resignFirstResponder()
            exerciseTextField.becomeFirstResponder()
        } else if exerciseTextField.isEditing {
            exerciseTextField.resignFirstResponder()
        }
    }
    
    
    func refreshExerciseList(bp: String) {
        
        let request = Exercise.fetchRequest() as NSFetchRequest<Exercise>
        request.predicate = NSPredicate(format: "bodyPart == '\(bp)'")
        
        do {
            exerciseData = try context.fetch(request)
        } catch let error as NSError {
            print("Could no fetch exerciseData. \(error), \(error.userInfo)")
        }
        
        exercisePicker.reloadAllComponents()
    }
    
}


/*
 * Picker
 */
extension Exercises_TVC: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var returnInt = 0
        
        if pickerView == bodyPartPicker {
            returnInt = bodyPartData.count
        } else if pickerView == exercisePicker {
            returnInt = exerciseData.count
        }
        
        return returnInt
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        var returnStr = ""
        
        if pickerView == bodyPartPicker {
            returnStr = bodyPartData[row]
        } else if pickerView == exercisePicker {
            returnStr = exerciseData[row].name
        }
        
        return returnStr
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == bodyPartPicker {
            selectedBodyPart = bodyPartData[row]
            bodyPartTextField.text = selectedBodyPart
            refreshExerciseList(bp: selectedBodyPart!)
        } else if pickerView == exercisePicker {
            selectedExercise = exerciseData[row].name
            exerciseTextField.text = selectedExercise
        }
    }
}


