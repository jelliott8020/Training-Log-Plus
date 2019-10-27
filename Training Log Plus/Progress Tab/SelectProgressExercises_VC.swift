//
//  SelectProgressExercisesViewController.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 9/11/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit


protocol PassDataBackProtocol {
    func passDataBack(bodyPart: String, exercise: String, start: String, end: String)
}

class SelectProgressExercises_VC: UITableViewController {
    
    var delegate: PassDataBackProtocol?
    
    var bodyPartData: [String] = []
    var exerciseData: [String] = []
    var startDateData: [String] = []
    var endDateData: [String] = []
    
    var selectedBodyPart: String?
    var selectedExercise: String?
    var selectedStartDate: String?
    var selectedEndDate: String?
    
    var bodyPartPicker = UIPickerView()
    var exercisePicker = UIPickerView()
    var startDatePicker = UIDatePicker()
    var endDatePicker = UIDatePicker()
    
    @IBOutlet weak var bodyPartTextField: UITextField!
    @IBOutlet weak var exerciseTextField: UITextField!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    
    @IBAction func cancelButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doneButton(_ sender: Any) {
        doneAction()
    }
    
    func doneAction() {
        if let body = bodyPartTextField.text, let exer = exerciseTextField.text, let start = startDateTextField.text, let end = endDateTextField.text {
            
            if (checkForGoodInput(body, exer, start, end)) {
                return
            }
            
            delegate?.passDataBack(bodyPart: selectedBodyPart!, exercise: selectedExercise!, start: selectedStartDate!, end: selectedEndDate!)
            dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        bodyPartData = getBodyPartData()
        // Maybe check for bodypart selection before filling in exercise data
        let bodyPart: String = ""
        exerciseData = getExerciseData(bodyPart)
        
        createPickers()
        createToolbarDoneButton()
        showDatePicker()
    }
    
    func showDatePicker() {
        endDatePicker.datePickerMode = .date
        startDatePicker.datePickerMode = .date
        
        let startToolBar = UIToolbar()
        let endToolBar = UIToolbar()
        startToolBar.sizeToFit()
        endToolBar.sizeToFit()
        
        let startDoneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneStartDatePicker))
        let endDoneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneEndDatePicker))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        //let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        
        startToolBar.setItems([spaceButton, startDoneButton], animated: false)
        endToolBar.setItems([spaceButton, endDoneButton], animated: false)
        
        endDateTextField.inputAccessoryView = endToolBar
        startDateTextField.inputAccessoryView = startToolBar
    }
    
    func createPickers() {
        bodyPartPicker.delegate = self
        exercisePicker.delegate = self
        
        bodyPartTextField.inputView = bodyPartPicker
        exerciseTextField.inputView = exercisePicker
        startDateTextField.inputView = startDatePicker
        endDateTextField.inputView = endDatePicker
        
    }
    
    func createToolbarDoneButton() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonAction))
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        bodyPartTextField.inputAccessoryView = toolBar
        exerciseTextField.inputAccessoryView = toolBar
    }
    
    @objc func doneButtonAction() {
        
        if bodyPartTextField.isEditing {
            bodyPartTextField.resignFirstResponder()
            exerciseTextField.becomeFirstResponder()
        } else if exerciseTextField.isEditing {
            exerciseTextField.resignFirstResponder()
            startDateTextField.becomeFirstResponder()
        }
    }
    
    @objc func doneStartDatePicker() {
        //For date formate
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        startDateTextField.text = formatter.string(from: startDatePicker.date)
        selectedStartDate = startDateTextField.text
        //dismiss date picker dialog
        
        startDateTextField.resignFirstResponder()
        endDateTextField.becomeFirstResponder()
    }
    
    @objc func doneEndDatePicker() {
        //For date formate
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        endDateTextField.text = formatter.string(from: endDatePicker.date)
        selectedEndDate = endDateTextField.text
        //dismiss date picker dialog
        
        doneAction()
        self.view.endEditing(true)
    }

//    @objc func cancelDatePicker(){
//        //cancel button dismiss datepicker dialog
//        self.view.endEditing(true)
//    }
    
    func getBodyPartData() -> [String] {
        return ["Chest", "Back", "Shoulders", "Arms", "Legs", "Abs", "Misc"]
    }
    
    func getExerciseData(_ bodyPart: String) -> [String] {
        
        // Maybe check for bodypart selection before filling in exercise data
        // Query Core Date for exercises here after getting bodypart
        return ["Bench", "Squat", "Deadlift"]
    }
    
    func checkForGoodInput(_ bodyPart: String, _ exer: String, _ start: String, _ end: String) -> Bool {
        if (bodyPart == "" || start == "" || exer == "" || end == "") {
            
            if (bodyPart == "") {
                shakeAndRedTextField(bodyPartTextField)
            } else {
                returnToDefaultTextField(bodyPartTextField)
            }
            
            if (start == "") {
                shakeAndRedTextField(startDateTextField)
            } else {
                returnToDefaultTextField(startDateTextField)
            }
            
            if (exer == "") {
                shakeAndRedTextField(exerciseTextField)
            } else {
                returnToDefaultTextField(exerciseTextField)
            }
            
            if (end == "") {
                shakeAndRedTextField(endDateTextField)
            } else {
                returnToDefaultTextField(endDateTextField)
            }

            
            return true
        }
        return false
    }
    
    func shakeAndRedTextField(_ textField: UITextField) {
        let redColor = UIColor.red
        textField.shake()
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = redColor.cgColor
    }
    
    func returnToDefaultTextField(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 5
    }
    

}

extension SelectProgressExercises_VC: UIPickerViewDataSource, UIPickerViewDelegate {
    
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
