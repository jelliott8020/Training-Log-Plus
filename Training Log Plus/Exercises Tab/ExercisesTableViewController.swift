//
//  ExercisesTableViewController.swift
//  Training Log Plus
//
//  Created by Elliott, Josh on 9/29/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit

class ExercisesTableViewController: UITableViewController {

    
    @IBAction func createButton(_ sender: UIBarButtonItem) {
        // Add item to data here
    }
    
    
    @IBAction func clearButton(_ sender: UIBarButtonItem) {
        bodyPartTextField.text = ""
        exerciseNameTextField.text = ""
        startingWeightTextField.text = ""
        maxRepsTextField.text = ""
    }
    
    
    @IBOutlet weak var bodyPartTextField: UITextField!
    @IBOutlet weak var exerciseNameTextField: UITextField!
    @IBOutlet weak var startingWeightTextField: UITextField!
    @IBOutlet weak var maxRepsTextField: UITextField!
    
    
    var bodyPartData: [String] = []
    var maxRepsData: [String] = []
    var startingWeightData: [String] = []
    
    var selectedBodyPart: String?
    var selectedStartingWeight: String?
    var selectedMaxReps: String?
    
    var bodyPartPicker = UIPickerView()
    var startingWeightPicker = UIPickerView()
    var maxRepsPicker = UIPickerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bodyPartData = getBodyPartData()
        maxRepsData = getMaxRepsData()
        startingWeightData = getStartingWeightData()
        
        createPickers()
        createToolbarDoneButton()
    }
    
    func createPickers() {
        
        bodyPartPicker.delegate = self
        startingWeightPicker.delegate = self
        maxRepsPicker.delegate = self
        
        bodyPartTextField.inputView = bodyPartPicker
        startingWeightTextField.inputView = startingWeightPicker
        maxRepsTextField.inputView = maxRepsPicker
    }
    
    func createToolbarDoneButton() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonAction))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        bodyPartTextField.inputAccessoryView = toolBar
        maxRepsTextField.inputAccessoryView = toolBar
        startingWeightTextField.inputAccessoryView = toolBar
    }
    
    @objc func doneButtonAction() {
        self.view.endEditing(true)
    }
    
    
    func getBodyPartData() -> [String] {
        return ["Chest", "Back", "Shoulders", "Arms", "Legs", "Abs", "Misc"]
    }
    
    func getMaxRepsData() -> [String] {
        var returnArg: [String] = []
        
        for i in 0...20 {
            returnArg.append(String(i))
        }
        
        return returnArg
    }
    
    func getStartingWeightData() -> [String] {
        var returnArg: [String] = []
        
        for i in 5...500 {
            if i % 5 == 0 {
                returnArg.append(String(i))
            }
        }
        
        return returnArg
    }
    
    
}

extension ExercisesTableViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var returnInt = 0
        
        if pickerView == bodyPartPicker {
            returnInt = bodyPartData.count
        } else if pickerView == maxRepsPicker {
            returnInt = maxRepsData.count
        } else if pickerView == startingWeightPicker {
            returnInt = startingWeightData.count
        }
        
        return returnInt
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        var returnStr = ""
        
        if pickerView == bodyPartPicker {
            returnStr = bodyPartData[row]
        } else if pickerView == maxRepsPicker {
            returnStr = maxRepsData[row]
        } else if pickerView == startingWeightPicker {
            returnStr = startingWeightData[row]
        }
        
        return returnStr
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == bodyPartPicker {
            selectedBodyPart = bodyPartData[row]
            bodyPartTextField.text = selectedBodyPart
        } else if pickerView == maxRepsPicker {
            selectedMaxReps = maxRepsData[row]
            maxRepsTextField.text = selectedMaxReps
        } else if pickerView == startingWeightPicker {
            selectedStartingWeight = startingWeightData[row]
            startingWeightTextField.text = selectedStartingWeight
        }
    }
}


