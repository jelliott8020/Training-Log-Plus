//
//  TrainingMaxCalcViewController.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 10/16/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit
import CoreData

class TrainingMaxCalc_VC: UIViewController, UITextFieldDelegate {
    
    var exerciseData: [Exercise] = []
    var bodypartData: [String] = []
    var calcedArrayObj: [TMCell] = []
    
    var selectedWeight: Int?
    var selectedReps: Int?
    var selectedExercise: Wen_Exercise?
    var selectedTmToAdd: Int?
    var selectedBodyPart: String?
    
    var exercisePicker = UIPickerView()
    var bodypartPicker = UIPickerView()
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    @IBOutlet weak var calcedTable: UITableView!
    
    @IBOutlet weak var repsTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var exerciseTextField: UITextField!
    @IBOutlet weak var selectTmToAddTextField: UITextField!
    @IBOutlet weak var bodypartTextField: UITextField!
    
    @IBAction func calculateButton(_ sender: UIButton) {
        calculateButtonFunction()
    }
    @IBAction func addTmToExerciseButton(_ sender: UIButton) {
        addTmToExerciseFunction()
    }
    @IBAction func clearData(_ sender: UIBarButtonItem) {
        clearDataFunction()
    }
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    
    /*
     * View Did Load
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        calcedTable.tableFooterView = UIView(frame: CGRect.zero)

        bodypartData = Util.getBodyPartData()
        
        createPickers()
        createToolbarDoneButton()
        
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
    }
    
    
    /*
    * Calculate Button
    *
    * Calculate the training max and add to table
    */
    func calculateButtonFunction() {
        if let weight = weightTextField.text, let reps = repsTextField.text {
            
            if (Util.checkForBlankInput(str: weight, txtField: weightTextField)) {return}
            if (Util.checkForBlankInput(str: reps, txtField: repsTextField)) {return}
            
            insertNewCalc()
        }
    }
    
    
    /*
    * Add TM Button
    *
    * Adds the TM and Exercise selected to the database with the
    * current date
    */
    func addTmToExerciseFunction() {
        if let tmWeight = selectTmToAddTextField.text, let exerName = exerciseTextField.text {
            
            if (Util.checkForBlankInput(str: tmWeight, txtField: selectTmToAddTextField)) {return}
            if (Util.checkForBlankInput(str: exerName, txtField: exerciseTextField)) {return}
            
            let tm = TrainingMax(entity: TrainingMax.entity(), insertInto: context)
            tm.date = Date.init()
            tm.trainingMax = Double(tmWeight)!
            selectedExercise?.addToTrainingMaxes(tm)
            appDelegate.saveContext()
        }
    }
    
    
    /*
    * Clear Data Button
    *
    * Clears data from all the text fields
    */
    func clearDataFunction() {
        //calcedWeightsArray.removeAll()
        calcedArrayObj.removeAll()
        calcedTable.reloadData()
        exerciseTextField.text = ""
        selectedExercise = nil
        selectedBodyPart = ""
        weightTextField.text = ""
        repsTextField.text = ""
        selectTmToAddTextField.text = ""
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
}


/**
 * PICKER
 */
extension TrainingMaxCalc_VC: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var returnInt = 0
        
        if pickerView == exercisePicker {
            returnInt = exerciseData.count
        } else if pickerView == bodypartPicker {
            returnInt = bodypartData.count
        }
        
        return returnInt
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        var returnStr = ""
        
        if pickerView == exercisePicker {
            returnStr = exerciseData[row].name
        } else if pickerView == bodypartPicker {
            returnStr = bodypartData[row]
        }
        
        return returnStr
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == exercisePicker {
            selectedExercise = exerciseData[row] as? Wen_Exercise
            exerciseTextField.text = selectedExercise?.name
        } else if pickerView == bodypartPicker {
            selectedBodyPart = bodypartData[row]
            bodypartTextField.text = selectedBodyPart
            DataManager.getWenExercise(exStr: selectedBodyPart!, exData: &exerciseData)
            print(selectedBodyPart as Any)
            print(exerciseData)
            exercisePicker.reloadAllComponents()
        }
    }
}



/**
 * TABLEVIEW
 */
extension TrainingMaxCalc_VC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calcedArrayObj.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let weightForCell = calcedArrayObj[indexPath.row].displayString
        
        let item = calcedArrayObj[indexPath.row]
        let weightForCell = Util.getTMDisplayString(trainingMax: item.trainingMax, weight: item.weight, reps: item.reps)
        
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

/**
 * UTILITY FUNCTIONS
 */
extension TrainingMaxCalc_VC {
    
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
     * Create Pickers Function
     *
     * Creates the pickers for the view
     */
    func createPickers() {
        exercisePicker.delegate = self
        exerciseTextField.inputView = exercisePicker
        
        bodypartPicker.delegate = self
        bodypartTextField.inputView = bodypartPicker
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
        bodypartTextField.inputAccessoryView = toolBar
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
        } else if repsTextField.isEditing {
            repsTextField.resignFirstResponder()
            insertNewCalc()
            self.view.endEditing(true)
        } else if bodypartTextField.isEditing {
            bodypartTextField.resignFirstResponder()
            exerciseTextField.becomeFirstResponder()
        }else if exerciseTextField.isEditing {
            exerciseTextField.resignFirstResponder()
            selectTmToAddTextField.becomeFirstResponder()
        } else if selectTmToAddTextField.isEditing {
            selectTmToAddTextField.resignFirstResponder()
            addTmToExerciseFunction()
            self.view.endEditing(true)
        }
    }
}
