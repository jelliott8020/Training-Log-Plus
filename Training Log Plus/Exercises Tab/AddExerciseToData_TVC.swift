//
//  AddExercise_TVC.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 10/19/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit

class AddExerciseToData_TVC: UITableViewController {

    
    @IBOutlet weak var bodyPartTextField: UITextField!
    @IBOutlet weak var exerciseTextField: UITextField!
    @IBOutlet weak var wendlerTextField: UITextField!
    
    var bodyPartData: [String] = []
    var exerciseData: [String] = []
    var wendlerData: [String] = []
    
    var selectedBodyPart: String?
    var selectedExercise: String?
    var selectedWendler: String?
    
    var bodyPartPicker = UIPickerView()
    var wendlerPicker = UIPickerView()

    
    /*
     View Did Load
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bodyPartData = getBodyPartData()
        wendlerData = getWendlerData()
        
        createPickers()
        createToolbarDoneButton()

        // Edit button
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    /*
     Add to Data Button
     
     Adds the data to the database
     */
    @IBAction func addToDataButton(_ sender: UIButton) {
        if let body = bodyPartTextField.text, let exer = exerciseTextField.text, let wen = wendlerTextField.text {
            
            var check = false
            let util = UtilityFunctions()
            
            check = util.checkForBlankInput(str: body, txtField: bodyPartTextField)
            check = util.checkForBlankInput(str: exer, txtField: exerciseTextField)
            check = util.checkForBlankInput(str: wen, txtField: wendlerTextField)
            
            if (check) {
                return
            }
        }
        
        selectedBodyPart = bodyPartTextField.text
        selectedExercise = exerciseTextField.text
        
        print(selectedExercise!)
        print(selectedBodyPart!)
        print(selectedWendler!)
        
        // Add to database here
        // Also add with toolbar done button below
    }
    
    
    
    
    
    /*
     Clear Button
     
     IBAction for Clear Button on View
     Clears all the textFields
     */
    @IBAction func clearButton(_ sender: UIBarButtonItem) {
        clearButtonFunction()
    }
    
    
    /*
     Cancel Button
     
     IBAction for Cancel Button on view
     Pops the View Controller off the stack
     */
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    
    /*
     * Create Pickers
     *
     * Creates the pickers for the view
     */
    func createPickers() {
        bodyPartPicker.delegate = self
        wendlerPicker.delegate = self
        
        bodyPartTextField.inputView = bodyPartPicker
        wendlerTextField.inputView = wendlerPicker
    }
    
    
    /*
     * Create Tool Bar Done Button
     *
     * Creates done buttons for toolbars
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
        wendlerTextField.inputAccessoryView = toolBar
    }
    
    /*
     * Done Button Action
     *
     * Tells the toolbar what to do when done button is selected
     */
    @objc func doneButtonAction() {
        if bodyPartTextField.isEditing {
            bodyPartTextField.resignFirstResponder()
            exerciseTextField.becomeFirstResponder()
        } else if exerciseTextField.isEditing {
            exerciseTextField.resignFirstResponder()
            wendlerTextField.becomeFirstResponder()
        } else if wendlerTextField.isEditing {
            // Add to DB here
            self.view.endEditing(true)
        }
    }
}


/*
 Utility Functions
 */
extension AddExerciseToData_TVC {
    
    /*
     Get Wendler Data
     
     Returns data to fill Wendler Picker
     */
    func getWendlerData() -> [String] {
        return ["Yes", "No"]
    }
    
    
    /*
     Get BodyPart Data
     
     Returns data to fill BodyPart Picker
     */
    func getBodyPartData() -> [String] {
        return ["Chest", "Back", "Shoulders", "Arms", "Legs", "Abs", "Misc"]
    }
    
    
    /*
     Clear Button Function
     
     Clears data from the textfields
     */
    func clearButtonFunction() {
        bodyPartTextField.text = ""
        exerciseTextField.text = ""
        wendlerTextField.text = ""
        selectedWendler = "Yes"
    }
}


/*
 * Picker
 *
 * Delegate and Data Source
 */
extension AddExerciseToData_TVC: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var returnInt = 0
        
        if pickerView == bodyPartPicker {
            returnInt = bodyPartData.count
        } else if pickerView == wendlerPicker {
            returnInt = wendlerData.count
        }
        
        return returnInt
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        var returnStr = ""
        
        if pickerView == bodyPartPicker {
            returnStr = bodyPartData[row]
        } else if pickerView == wendlerPicker {
            returnStr = wendlerData[row]
        }
        
        return returnStr
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == bodyPartPicker {
            selectedBodyPart = bodyPartData[row]
            bodyPartTextField.text = selectedBodyPart
        } else if pickerView == wendlerPicker {
            selectedWendler = wendlerData[row]
            wendlerTextField.text = selectedWendler
        }
    }
}
