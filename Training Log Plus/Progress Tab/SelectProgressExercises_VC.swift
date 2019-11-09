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
    
    
    /*
     * View Did Load
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        bodyPartData = Util.getBodyPartData()
        // Maybe check for bodypart selection before filling in exercise data
        //let bodyPart: String = ""
        // Will need to check data for bodypart before filling this in
        exerciseData = Util.getGenericExerciseData()
        
        createPickers()
        createToolbarDoneButton()
        showDatePicker()
    }
    
    
    /*
     * Done Button Action
     *
     * Checks for good data and then passes the textfields back to Progress VC
     */
    func doneAction() {
        if let body = bodyPartTextField.text, let exer = exerciseTextField.text, let start = startDateTextField.text, let end = endDateTextField.text {
            
            if (Util.checkForBlankInput(str: body, txtField: bodyPartTextField)) {return}
            if (Util.checkForBlankInput(str: exer, txtField: exerciseTextField)) {return}
            if (Util.checkForBlankInput(str: start, txtField: startDateTextField)) {return}
            if (Util.checkForBlankInput(str: end, txtField: endDateTextField)) {return}
            
            
            delegate?.passDataBack(bodyPart: selectedBodyPart!, exercise: selectedExercise!, start: selectedStartDate!, end: selectedEndDate!)
            dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    /*
     * Show Data Picker
     *
     * Creates date pickers and adds toolbars to them
     */
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
        
        startToolBar.setItems([spaceButton, startDoneButton], animated: false)
        endToolBar.setItems([spaceButton, endDoneButton], animated: false)
        
        endDateTextField.inputAccessoryView = endToolBar
        startDateTextField.inputAccessoryView = startToolBar
    }
    
    
    /*
     * Create Pickers
     */
    func createPickers() {
        bodyPartPicker.delegate = self
        exercisePicker.delegate = self
        
        bodyPartTextField.inputView = bodyPartPicker
        exerciseTextField.inputView = exercisePicker
        startDateTextField.inputView = startDatePicker
        endDateTextField.inputView = endDatePicker
    }
    
    
    /*
     * Creete Toolbar Done Button
     */
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
    
    
    /*
     * Done button action
     */
    @objc func doneButtonAction() {
        
        if bodyPartTextField.isEditing {
            bodyPartTextField.resignFirstResponder()
            exerciseTextField.becomeFirstResponder()
        } else if exerciseTextField.isEditing {
            exerciseTextField.resignFirstResponder()
            startDateTextField.becomeFirstResponder()
        }
    }
    
    
    /*
     * Done action for start date picker
     */
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
    
    
    /*
     * Done action for end date picker
     */
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
