//
//  TemplateDayCreation_VC.swift
//  Training Log Plus
//
//  Created by Elliott, Josh on 10/24/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit
import CoreData


protocol Pass_WorkoutDayObject_BackTo_AddEditTemplate_Delegate {
    //func passWorkoutObjBack(workoutObj: WorkoutDay)
    // User hit cancel
    func workoutDayObject_DidCancel(_ controller: WorkoutDayCreation_VC)
    // User added item
    func workoutDayObjectCreation_PassTo_AddEditTemplate(_ controller: WorkoutDayCreation_VC, didFinishAdding item: WorkoutDay)
    // User finishes editing
    func workoutDayObjectCreation_PassTo_AddEditTemplate(_ controller: WorkoutDayCreation_VC, didFinishEditing item: WorkoutDay)
}


class WorkoutDayCreation_VC: UIViewController {
    
    var delegate: Pass_WorkoutDayObject_BackTo_AddEditTemplate_Delegate?
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var passedInWorkoutObj: WorkoutDay?
    var accExerciseList: [Exercise] = []
    var mainExerciseList: [Exercise] = []
    
    var bodypartTextField: UITextField?
    var exerciseTextField: UITextField?
    
    var bodypartPicker = UIPickerView()
    var exercisePicker = UIPickerView()
    
    var bodyPartData: [String] = []
    var exerciseData: [Exercise] = []
    
    var alertBodypart: String?
    var alertExercise: String?
    
    var selectedBodyPart: String?
    var selectedExercise: Exercise?
    
    @IBOutlet weak var workoutNameTextField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var exerciseTable: UITableView!
    
    @IBAction func updateNameButton(_ sender: UIButton) {
        updateNameFunction()
    }
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        doneButtonAction()
    }
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    
    /*
     * View Did Load
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exerciseTable.tableFooterView = UIView(frame: CGRect.zero)
        
        accExerciseList = passedInWorkoutObj!.accExerciseList?.allObjects as! [Exercise]
        mainExerciseList = passedInWorkoutObj!.mainExerciseList?.allObjects as! [Exercise]
        
        bodyPartData = Util.getBodyPartData()
        
        createPickers()
        //createToolbarDoneButton()
        //workoutObj?.title = passedTitle
        self.title = passedInWorkoutObj?.name
    }
    
    /*
     * Done Button Action
     *
     * Updates title of WorkoutDay Object, passes it back to parent VC
     */
    func doneButtonAction() {
        //        if let name = workoutNameTextField.text {
        //
        //            workoutObj?.title = name
        //
        //            //delegate?.passWorkoutObjBack(workoutObj: workoutObj!)
        //
        //
        //        }
        
        delegate?.workoutDayObjectCreation_PassTo_AddEditTemplate(self, didFinishEditing: passedInWorkoutObj!)
        
        appDelegate.saveContext()
        
        dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    /*
     * Update Name Function
     *
     * Updates the name from the textfield
     * Updates the object's title as well
     */
    func updateNameFunction() {
        if let title = workoutNameTextField.text {
            
            if (Util.checkForBlankInput(str: title, txtField: workoutNameTextField)) {return}
            
            self.title = workoutNameTextField.text
            passedInWorkoutObj?.name = workoutNameTextField.text!
        }
    }
    
    
    /*
     * Prepare for Segue
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "MainExSegue" {
            if let mainEx_VC = segue.destination as? AddEdit_MainExercise_VC {
                if let cell = sender as? UITableViewCell, let indexPath = exerciseTable.indexPath(for: cell) {
                    
                    let item = mainExerciseList[indexPath.row]
                    mainEx_VC.passedInExerciseObj = item
                    mainEx_VC.isItMain = true
                    mainEx_VC.delegate = self
                }
                
            }
        } else if segue.identifier == "AccExSegue" {
            if let mainEx_VC = segue.destination as? AddEdit_MainExercise_VC {
                if let cell = sender as? UITableViewCell, let indexPath = exerciseTable.indexPath(for: cell) {
                    
                    let item = accExerciseList[indexPath.row]
                    mainEx_VC.passedInExerciseObj = item
                    mainEx_VC.isItMain = false
                    mainEx_VC.delegate = self
                }
                
            }
        }
        
//        if (table == 0) {
//            self.passedInWorkoutObj?.addToMainExerciseList(newExercise)
//            self.mainExerciseList.append(newExercise)
//        } else {
//            self.passedInWorkoutObj?.addToAccExerciseList(newExercise)
//            self.accExerciseList.append(newExercise)
//        }
//
//        self.exerciseTable.reloadData()
    }
}


/**
 * TABLE VIEW
 */
extension WorkoutDayCreation_VC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return mainExerciseList.count
        } else if section == 1 {
            return accExerciseList.count
        }
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dummyCell = UITableViewCell()
        
        if indexPath.section == 0 {
            let weightForCell = mainExerciseList[indexPath.row].name
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainExercise") as! DayMainExercise_TVCell
            cell.mainExerLabel.text = weightForCell
            return cell
        } else if indexPath.section == 1 {
            let weightForCell = accExerciseList[indexPath.row].name
            let cell = tableView.dequeueReusableCell(withIdentifier: "AccessoryExercise") as! DayAccExercise_TVCell
            cell.accExerLabel.text = weightForCell
            return cell
        }
        
        return dummyCell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        
        if section == 0 {
            label.text = "Main Exercise"
            label.textColor = UIColor.white
            label.font = UIFont.boldSystemFont(ofSize: 17.0)
            label.textAlignment = .center
        } else if section == 1 {
            label.text = "Accessory Exercises"
            label.textColor = UIColor.white
            label.font = UIFont.boldSystemFont(ofSize: 17.0)
            label.textAlignment = .center
        }
        
        label.backgroundColor = UIColor(rgb: 0x2980B9)
        return label
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    /*
     * When user interacts with cell
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Prevents cell from being opened while in edit mode
        if tableView.isEditing {
            return
        }
        
        // Animation to show they interacted
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    /*
     * Swipe to delete
     */
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let alert = UIAlertController(title:  "Are you sure?", message: "", preferredStyle: .alert)
            
            let noButton = UIAlertAction(title: "No", style: UIAlertAction.Style.destructive, handler: nil)
            let yesButton = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { (action) -> Void in
                self.accExerciseList.remove(at: indexPath.row)
                
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
                
            } )
            
            alert.addAction(yesButton)
            alert.addAction(noButton)
            
            present(alert, animated: true, completion: nil)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
}


/**
 * PICKER
 */
extension WorkoutDayCreation_VC: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var returnInt = 0
        
        if pickerView == bodypartPicker {
            returnInt = bodyPartData.count
        } else if pickerView == exercisePicker {
            returnInt = exerciseData.count
        }
        
        return returnInt
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        var returnStr = ""
        
        if pickerView == bodypartPicker {
            returnStr = bodyPartData[row]
        } else if pickerView == exercisePicker {
            returnStr = exerciseData[row].name
        }
        
        return returnStr
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == bodypartPicker {
            selectedBodyPart = bodyPartData[row]
            //bodypartTextField!.text = selectedBodyPart
            DataManager.getExercises(bp: selectedBodyPart!, exData: &exerciseData)
        } else if pickerView == exercisePicker {
            selectedExercise = exerciseData[row]
            //exerciseTextField?.text = selectedExercise
        }
    }
}


/**
 * PASSBACK DELEGATE
 */
extension WorkoutDayCreation_VC: Pass_MainExerciseObject_BackTo_WorkoutDayCreation_Delegate {
    
    /*
     * Cancel button will pop the view controller
     */
    func addEditMainExercise_DidCancel(_ controller: AddEdit_MainExercise_VC) {
        navigationController?.popViewController(animated: true)
    }
    
    
    /*
     * After adding, data is passed back
     *
     * MAIN
     */
    func addEditMainExercise_PassTo_workoutDayObjectCreation(_ controller: AddEdit_MainExercise_VC, didFinishAdding item: Exercise) {
        //navigationController?.popViewController(animated: true)
        mainExerciseList.append(item)
        let rowIndex = mainExerciseList.count - 1
        let indexPath = IndexPath(row: rowIndex, section: 0)
        exerciseTable.insertRows(at: [indexPath], with: .automatic)
        exerciseTable.reloadData()
    }
    
    /*
     * After adding, data is passed back
     *
     * ACCESSORY
     */
    func addEditAccExercise_PassTo_workoutDayObjectCreation(_ controller: AddEdit_MainExercise_VC, didFinishAdding item: Exercise) {
        //navigationController?.popViewController(animated: true)
        accExerciseList.append(item)
        let rowIndex = accExerciseList.count - 1
        let indexPath = IndexPath(row: rowIndex, section: 1)
        exerciseTable.insertRows(at: [indexPath], with: .automatic)
        exerciseTable.reloadData()
    }
    
    
    /*
     * After editing, data is passed back
     *
     * MAIN
     */
    func addEditMainExercise_PassTo_workoutDayObjectCreation(_ controller: AddEdit_MainExercise_VC, didFinishEditing item: Exercise) {
        if let index = mainExerciseList.firstIndex(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = exerciseTable.cellForRow(at: indexPath) {
                cell.textLabel?.text = item.name
            }
        }
        exerciseTable.reloadData()
        //navigationController?.popViewController(animated: true)
    }
    
    /*
     * After editing, data is passed back
     *
     * ACCESSORY
     */
    func addEditAccExercise_PassTo_workoutDayObjectCreation(_ controller: AddEdit_MainExercise_VC, didFinishEditing item: Exercise) {
        if let index = accExerciseList.firstIndex(of: item) {
            let indexPath = IndexPath(row: index, section: 1)
            if let cell = exerciseTable.cellForRow(at: indexPath) {
                cell.textLabel?.text = item.name
            }
        }
        exerciseTable.reloadData()
        //navigationController?.popViewController(animated: true)
    }
}

/**
 * UTILITY FUNCTIONS
 */
extension WorkoutDayCreation_VC {
    
    /*
     * Create Pickers
     */
    func createPickers() {
        exercisePicker.delegate = self
        bodypartPicker.delegate = self
        
        exerciseTextField?.inputView = exercisePicker
        bodypartTextField?.inputView = bodypartPicker
    }
    
    
    /*
     * Create Tool Bar Done Button
     */
    func createToolbarDoneButton() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(toolbarDoneButtonAction))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    
    
    /*
     * Toolbar Done Button Action
     */
    @objc func toolbarDoneButtonAction() {
        if bodypartTextField!.isEditing {
            bodypartTextField!.resignFirstResponder()
            exerciseTextField!.becomeFirstResponder()
        } else if exerciseTextField!.isEditing {
            exerciseTextField!.resignFirstResponder()
            //addButtonFunction()
            self.view.endEditing(true)
        }
    }
    
}


/**
 * UICOLOR
 */
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
