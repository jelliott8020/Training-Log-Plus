//
//  AddExercise_TVC.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 10/19/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit
import CoreData

class AddExerciseToData_TVC: UITableViewController {

    var bodyPartData: [String] = []
    var wendlerData: [String] = []
    
    var selectedBodyPart: String?
    var selectedExercise: String?
    var selectedWendler: String?
    
    var bodyPartPicker = UIPickerView()
    var wendlerPicker = UIPickerView()
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    @IBOutlet weak var bodyPartTextField: UITextField!
    @IBOutlet weak var exerciseTextField: UITextField!
    @IBOutlet weak var wendlerTextField: UITextField!

    @IBAction func addToDataButton(_ sender: UIButton) {
        addButtonFunction()
    }
    @IBAction func clearButton(_ sender: UIBarButtonItem) {
        clearButtonFunction()
    }
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    
    /*
     * View Did Load
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bodyPartData = Util.getBodyPartData()
        wendlerData = Util.getYesOrNoForPickerData()
        
        createPickers()
        createToolbarDoneButton()
    }
    
    
    /*
     * Add to Data Button
     *
     * Adds the data to the database
     */
    func addButtonFunction() {
        
        if let body = bodyPartTextField.text, let exer = exerciseTextField.text, let wen = wendlerTextField.text {
            
            if (Util.checkForBlankInput(str: body, txtField: bodyPartTextField)) {return}
            if (Util.checkForBlankInput(str: exer, txtField: exerciseTextField)) {return}
            if (Util.checkForBlankInput(str: wen, txtField: wendlerTextField)) {return}
            
            var item: AnyObject?
            
            if (wen.lowercased() == "yes") {
                item = Wen_Exercise(entity: Wen_Exercise.entity(), insertInto: context)
                (item as! Wen_Exercise).bodypart = bodyPartTextField.text!
                (item as! Wen_Exercise).name = exerciseTextField.text!
                //item.currentTM = 0.0
            } else {
                item = BB_Exercise(entity: BB_Exercise.entity(), insertInto: context)
                (item as! BB_Exercise).bodypart = bodyPartTextField.text!
                (item as! BB_Exercise).name = exerciseTextField.text!
                //item.startingWeight = 0
            }
            
            appDelegate.saveContext()
            
            dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        }
    }
}


/*
 * Picker Delegate and Data Source
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



/*
 * Utility Functions
 */
extension AddExerciseToData_TVC {
    
    /*
     * Toolbar Done Button
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
     * Toolbar Done Button Action
     */
    @objc func doneButtonAction() {
        if bodyPartTextField.isEditing {
            bodyPartTextField.resignFirstResponder()
            exerciseTextField.becomeFirstResponder()
        } else if exerciseTextField.isEditing {
            exerciseTextField.resignFirstResponder()
            wendlerTextField.becomeFirstResponder()
        } else if wendlerTextField.isEditing {
            wendlerTextField.resignFirstResponder()
            addButtonFunction()
            self.view.endEditing(true)
        }
    }
    
    /*
     * Clear Button Function
     */
    func clearButtonFunction() {
        Util.clearTextField(bodyPartTextField)
        Util.clearTextField(exerciseTextField)
        Util.clearTextField(wendlerTextField)
        selectedWendler = "Yes"
    }
    
    /*
     * Create Pickers
     */
    func createPickers() {
        bodyPartPicker.delegate = self
        wendlerPicker.delegate = self
        
        bodyPartTextField.inputView = bodyPartPicker
        wendlerTextField.inputView = wendlerPicker
    }
}
