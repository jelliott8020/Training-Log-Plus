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
    
    @IBOutlet weak var highestTMLabel: UILabel!
    
    var exerciseData: [String] = []
    var calcedWeightsArray: [Double] = []
    var calcedArrayObj: [TMCell] = []
    
    var selectedWeight: Int?
    var selectedReps: Int?
    var selectedExercise: String?
    var highestTMNum = 0.0
    
    var exercisePicker = UIPickerView()
    
    
    // Calculate and add to table button
    @IBAction func calculateButton(_ sender: UIButton) {
        insertNewCalc()
        
        // Update highest label here
    }
    
    // Add TM to Exercise
    @IBAction func addTmToExerciseButton(_ sender: UIButton) {
        // Add TM and current date to exercise data
    }
    
    // Clear Data button
    @IBAction func clearData(_ sender: UIBarButtonItem) {
        calcedWeightsArray.removeAll()
        calcedArrayObj.removeAll()
        highestTMNum = 0
        highestTMLabel.text = String(format: "%.0f", highestTMNum)
        calcedTable.reloadData()
        exerciseTextField.text = ""
        selectedExercise = ""
        
    }
    
    // Insert new calced cell to table
    func insertNewCalc() {
        let reps = repsTextField.text
        let weight = weightTextField.text
        
        if (reps != "" && weight != "") {
            let weightNum: Double? = Double(weight!)
            let repsNum: Double? = Double(reps!)
            
            let tmObj = TMCell(reps: repsNum!, weight: weightNum!)
            calcedArrayObj.append(tmObj)
            
            let tmNum = tmObj.trainingMax
            
            calcedWeightsArray.append(tmNum)
            
            if tmNum >= highestTMNum {
                highestTMNum = tmNum
                highestTMLabel.text = String(format: "%.0f", highestTMNum)
            }
            
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
    
    func filterList() {
        calcedArrayObj = calcedArrayObj.sorted() { $0.trainingMax > $1.trainingMax }
        calcedTable.reloadData();
    }
    
    func sorterForFileIDASC(this:TMCell, that:TMCell) -> Bool {
      return this.trainingMax > that.trainingMax
    }
    
    func rounder(_ value: Double, toNearest: Double) -> Double {
        return round(value / toNearest) * toNearest
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calcedTable.tableFooterView = UIView(frame: CGRect.zero)
        
        highestTMLabel.text = String(format: "%.0f", highestTMNum)
        
        exerciseData = getExerciseData()
        
        createPickers()
        createToolbarDoneButton()
    }
    
    
    func createPickers() {
        exercisePicker.delegate = self
        exerciseTextField.inputView = exercisePicker
    }
    
    func createToolbarDoneButton() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonAction))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        weightTextField.inputAccessoryView = toolBar
        repsTextField.inputAccessoryView = toolBar
    }
    
    @objc func doneButtonAction() {
        
        
        if weightTextField.isEditing {
            weightTextField.resignFirstResponder()
            repsTextField.becomeFirstResponder()
        } else if repsTextField.isEditing {
            insertNewCalc()
            self.view.endEditing(true)
        }
    }
    
    func getExerciseData() -> [String] {
        // Get data from database here
        
        return ["Squat", "Deadlift", "Bench"]
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == weightTextField {
            textField.resignFirstResponder()
            repsTextField.becomeFirstResponder()
        }
        return true
    }

}

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

extension TrainingMaxCalc_VC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calcedArrayObj.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weightForCell = calcedArrayObj[indexPath.row].displayString
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalcedCell") as! Calced_TVCell
        cell.calcedLabel.text = weightForCell
        
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
