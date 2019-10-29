//
//  ExercisesTableViewController.swift
//  Training Log Plus
//
//  Created by Elliott, Josh on 9/29/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit

class Exercises_TVC: UITableViewController {

    var bodyPartData: [String] = []
    var exerciseData: [String] = []
    
    var selectedBodyPart: String?
    var selectedExercise: String?
    
    var bodyPartPicker = UIPickerView()
    var exercisePicker = UIPickerView()
    
    
    @IBOutlet weak var bodyPartTextField: UITextField!
    @IBOutlet weak var exerciseTextField: UITextField!
    
    @IBAction func createButton(_ sender: UIBarButtonItem) {
        createButtonFunc()
    }
    @IBAction func clearButton(_ sender: UIBarButtonItem) {
        clearButtonFunction()
    }
    
    
    /*
     * View Did Load
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bodyPartData = Util.getGenericBodyPartData()
        
        // Will have to figure how to fill this AFTER bodypart picker is selected
        exerciseData = Util.getGenericExerciseData()
        
        createPickers()
        createToolbarDoneButton()
    }
    

    /*
     * Create Button Function
     *
     * Adds data to database
     */
    func createButtonFunc() {
        // Add item to data here
        selectedBodyPart = bodyPartTextField.text
        selectedExercise = exerciseTextField.text
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
            returnStr = exerciseData[row]
        }
        
        return returnStr
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == bodyPartPicker {
            selectedBodyPart = bodyPartData[row]
            bodyPartTextField.text = selectedBodyPart
        } else if pickerView == exercisePicker {
            selectedExercise = exerciseData[row]
            exerciseTextField.text = selectedExercise
        }
    }
}


