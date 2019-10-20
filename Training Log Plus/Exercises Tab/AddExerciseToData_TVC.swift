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
    @IBOutlet weak var wendlerSwitchOutlet: UISwitch!
    
    var bodyPartData: [String] = []
    var exerciseData: [String] = []
    
    var selectedBodyPart: String?
    var selectedExercise: String?
    var selectedWender: Bool?
    
    var bodyPartPicker = UIPickerView()
    var exercisePicker = UIPickerView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bodyPartData = getBodyPartData()
        exerciseData = getExerciseData()
        
        createPickers()
        createToolbarDoneButton()

        // Edit button
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    @IBAction func wendlerSwitch(_ sender: UISwitch) {
        if sender.isOn {
            selectedWender = true
        } else {
            selectedWender = false
        }
    }
    
    @IBAction func addToDataButton(_ sender: UIButton) {
        selectedBodyPart = bodyPartTextField.text
        selectedExercise = exerciseTextField.text
        
        print(selectedExercise!)
        print(selectedBodyPart!)
        print(selectedWender!)
    }
    
    @IBAction func clearButton(_ sender: UIBarButtonItem) {
        bodyPartTextField.text = ""
        exerciseTextField.text = ""
        wendlerSwitchOutlet.setOn(false, animated: true)
        selectedWender = false
    }
    
    func createPickers() {
        
        bodyPartPicker.delegate = self
        exercisePicker.delegate = self
        
        bodyPartTextField.inputView = bodyPartPicker
        exerciseTextField.inputView = exercisePicker
    }
    
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
    
    @objc func doneButtonAction() {
        self.view.endEditing(true)
    }
    
    func getBodyPartData() -> [String] {
        return ["Chest", "Back", "Shoulders", "Arms", "Legs", "Abs", "Misc"]
    }
    
    func getExerciseData() -> [String] {
        // Fill this from database after bodypart picker is selected
        return ["Squat", "Deadlift", "Bench"]
    }


}

extension AddExerciseToData_TVC: UIPickerViewDataSource, UIPickerViewDelegate {
    
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
        
//        else if pickerView == maxRepsPicker {
//            returnInt = maxRepsData.count
//        } else if pickerView == startingWeightPicker {
//            returnInt = startingWeightData.count
//        }
        
        return returnInt
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        var returnStr = ""
        
        if pickerView == bodyPartPicker {
            returnStr = bodyPartData[row]
        } else if pickerView == exercisePicker {
            returnStr = exerciseData[row]
        }
        
//        else if pickerView == maxRepsPicker {
//            returnStr = maxRepsData[row]
//        } else if pickerView == startingWeightPicker {
//            returnStr = startingWeightData[row]
//        }
        
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
        
//        else if pickerView == maxRepsPicker {
//            selectedMaxReps = maxRepsData[row]
//            maxRepsTextField.text = selectedMaxReps
//        } else if pickerView == startingWeightPicker {
//            selectedStartingWeight = startingWeightData[row]
//            startingWeightTextField.text = selectedStartingWeight
//        }
    }
}
