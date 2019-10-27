//
//  TrainingMaxCalcViewController.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 10/16/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit

class TrainingMaxCalc_VC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var calcedTable: UITableView!
    
    @IBOutlet weak var repsTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var exerciseTextField: UITextField!
    @IBOutlet weak var selectTmToAddTextField: UITextField!
    
    var exerciseData: [String] = []
    var calcedArrayObj: [TMCell] = []
    
    var selectedWeight: Int?
    var selectedReps: Int?
    var selectedExercise: String?
    var selectedTmToAdd: Int?
    
    var exercisePicker = UIPickerView()
    
    
    /*
     * Calculate Button
     *
     * Calculate the training max and add to table
     */
    @IBAction func calculateButton(_ sender: UIButton) {
        if let weight = weightTextField.text, let reps = repsTextField.text {
            if (checkForGoodCalcButtonInput(weight, reps)) {
                return
            }
            
            returnToDefaultTextField(weightTextField)
            returnToDefaultTextField(repsTextField)
            
            insertNewCalc()
        }
    }
    
    
    /*
     * Add TM Button
     *
     * Adds the TM and Exercise selected to the database with the current date
     */
    @IBAction func addTmToExerciseButton(_ sender: UIButton) {
        
        if let tmWeight = selectTmToAddTextField.text, let exerName = exerciseTextField.text {
            if (checkForGoodAddToTmInput(tmWeight, exerName)) {
                return
            }
            
            returnToDefaultTextField(selectTmToAddTextField)
            returnToDefaultTextField(exerciseTextField)
            
            // Add TM and current date to exercise data
            // Also go done and have done button from exercise call the method
            // Make sure to add current date to Exercise Object
        }
    }
    
    
    /*
     * Clear Data Button
     *
     * Clears data from all the text fields
     */
    @IBAction func clearData(_ sender: UIBarButtonItem) {
        //calcedWeightsArray.removeAll()
        calcedArrayObj.removeAll()
        calcedTable.reloadData()
        exerciseTextField.text = ""
        selectedExercise = ""
        weightTextField.text = ""
        repsTextField.text = ""
        selectTmToAddTextField.text = ""
        
    }
    
    
    /*
     * Cancel Button
     *
     * Cancels the view, pops the controller
     */
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        
        navigationController?.popViewController(animated: true)
    }
    
    
    /*
     * Insert New Calc Function
     *
     * Inserts a new calculated cell into the table
     */
    func insertNewCalc() {
        let reps = repsTextField.text
        let weight = weightTextField.text
        
        if (reps != "" && weight != "") {
            let weightNum: Double? = Double(weight!)
            let repsNum: Double? = Double(reps!)
            
            let tmObj = TMCell(reps: repsNum!, weight: weightNum!)
            calcedArrayObj.append(tmObj)
            
            let indexPath = IndexPath(row: calcedArrayObj.count - 1, section: 0)
            
            calcedTable.beginUpdates()
            calcedTable.insertRows(at: [indexPath], with: .automatic)
            calcedTable.endUpdates()
            
            filterList()
            
            weightTextField.text = ""
            repsTextField.text = ""
            view.endEditing(true)
        }
    }
    
    
    /*
     * Filter List Function
     *
     * Filters the list that populates the table, keeping the highest TM at the top
     */
    func filterList() {
        calcedArrayObj = calcedArrayObj.sorted() { $0.trainingMax > $1.trainingMax }
        calcedTable.reloadData();
    }
    
    
    /*
     * View Did Load
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        calcedTable.tableFooterView = UIView(frame: CGRect.zero)

        exerciseData = getExerciseData()
        
        createPickers()
        createToolbarDoneButton()
        
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
    }
    
    
    /*
     * Create Pickers Function
     *
     * Creates the pickers for the view
     */
    func createPickers() {
        exercisePicker.delegate = self
        exerciseTextField.inputView = exercisePicker
    }
    
    
    /*
     * Create Toolbar Done Button
     *
     * Creates done buttons for the pickers and text fields
     */
    func createToolbarDoneButton() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonAction))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        weightTextField.inputAccessoryView = toolBar
        repsTextField.inputAccessoryView = toolBar
        selectTmToAddTextField.inputAccessoryView = toolBar
        exerciseTextField.inputAccessoryView = toolBar
    }
    
    
    /*
     * Done Button Action
     *
     * Takes action when the toolbar done button is pressed
     */
    @objc func doneButtonAction() {
        if weightTextField.isEditing {
            weightTextField.resignFirstResponder()
            repsTextField.becomeFirstResponder()
        } else if selectTmToAddTextField.isEditing {
            selectTmToAddTextField.resignFirstResponder()
            exerciseTextField.becomeFirstResponder()
        } else if exerciseTextField.isEditing {
            // insert to database here
            self.view.endEditing(true)
        } else if repsTextField.isEditing {
            insertNewCalc()
            self.view.endEditing(true)
        }
    }
    
    
    /*
     * Get Exercise Data
     *
     * Populates the exercise data
     */
    func getExerciseData() -> [String] {
        // Get data from database here
        
        return ["Squat", "Deadlift", "Bench"]
    }
    
    
    /*
     * Text Field Should Return
     *
     * When hitting return, resigns current keyboard and opens up next
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == weightTextField {
            textField.resignFirstResponder()
            repsTextField.becomeFirstResponder()
        }
        return true
    }
    
    
    /*
     * Check For Good Calc Button Input
     *
     * Checks for the input before executing the calc button
     * Bad input will cause the textfields to turn red and shake
     */
    func checkForGoodCalcButtonInput(_ weight: String, _ reps: String) -> Bool {
        if (weight == "" || reps == "") {
            
            if (weight == "") {
                shakeAndRedTextField(weightTextField)
            } else {
                returnToDefaultTextField(weightTextField)
            }
            
            if (reps == "") {
                shakeAndRedTextField(repsTextField)
            } else {
                returnToDefaultTextField(repsTextField)
            }
            
            return true
        }
        return false
    }
    
    
    /*
     * Check For Good Add to TM Input
     *
     * Checks for the input before executing the add to tm button
     * Bad input will cause the textfields to turn red and shake
     */
    func checkForGoodAddToTmInput(_ tmWeight: String, _ exerName: String) -> Bool {
        if (tmWeight == "" || exerName == "") {
            
            if (tmWeight == "") {
                shakeAndRedTextField(selectTmToAddTextField)
            } else {
                returnToDefaultTextField(selectTmToAddTextField)
            }
            
            if (exerName == "") {
                shakeAndRedTextField(exerciseTextField)
            } else {
                returnToDefaultTextField(exerciseTextField)
            }
            
            return true
        }
        return false
    }
    
    
    /*
     * Shake and Red Text Field
     *
     * If called, will turn the textfield border red and shake
     */
    func shakeAndRedTextField(_ textField: UITextField) {
        let redColor = UIColor.red
        textField.shake()
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = redColor.cgColor
    }
    
    
    /*
     * Return to Default Text Field
     *
     * If called, will turn the textfield border back to default
     */
    func returnToDefaultTextField(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 5
    }
}

/*
 * Picker Delegate and Data Source
 */
extension TrainingMaxCalc_VC: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var returnInt = 0
        
        if pickerView == exercisePicker {
            returnInt = exerciseData.count
        }
        
        return returnInt
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        var returnStr = ""
        
        if pickerView == exercisePicker {
            returnStr = String(exerciseData[row])
        }
        
        return returnStr
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == exercisePicker {
            selectedExercise = exerciseData[row]
            exerciseTextField.text = selectedExercise
        }
    }
}

/*
 * TableView Delegate and Data Source
 */
extension TrainingMaxCalc_VC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calcedArrayObj.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weightForCell = calcedArrayObj[indexPath.row].displayString
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalcedCell") as! Calced_TVCell
        cell.calcedLabel.attributedText = weightForCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            calcedArrayObj.remove(at: indexPath.row)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
}
