//
//  AddItemTableViewController.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 9/8/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit


protocol ItemDetail_VCDelegate: class {
    // User hit cancel
    func itemDetailViewControllerDidCancel(_ controller: AddEditTemplate_VC)
    // User added item
    func itemDetailViewController(_ controller: AddEditTemplate_VC, didFinishAdding item: TemplateItem)
    // User finishes editing
    func itemDetailViewController(_ controller: AddEditTemplate_VC, didFinishEditing item: TemplateItem)
}


/*
 * This class allows 2 views, an Add and Edit
 */
class AddEditTemplate_VC: UIViewController, WorkoutCreationPassDataBackProtocol {
    

    // In order to use the protocol above, need a delegate
    // Any viewController that implements this protocol can be a delegate of the AddItemTableViewController
    weak var delegate: ItemDetail_VCDelegate?
    weak var templateList: TemplateList?
    weak var itemToEdit: TemplateItem?
    weak var globalTemplateItem: TemplateItem?
    
    @IBOutlet weak var doneButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var templateTitleTextField: UITextField!
    @IBOutlet weak var numDaysOfWeekTextField: UITextField!
    @IBOutlet weak var wendlerTextField: UITextField!
    @IBOutlet weak var numOfWeeksTextField: UITextField!
    @IBOutlet weak var workoutDaysTable: UITableView!
    
    var wendlerPicker = UIPickerView()
    var wendlerData: [String] = []
    var selectedWendler: String?
    
    var workoutDaysArray: [WorkoutDay] = []
    
    // Create
    @IBAction func createButton(_ sender: UIButton) {
        createButtonFunc()
    }
    
    // Cancel
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    
    // Done
    @IBAction func doneButtonAction(_ sender: UIBarButtonItem) {
        // Account for editing
        doneButtonActionFunc()
    }
    
    
    /*
     * Pass Workout Object Back
     *
     * Protocol function, receives the object from WorkoutDayCreation_VC
     */
    func passWorkoutObjBack(workoutObj: WorkoutDay) {
        print("")
        
        // Just replacing the first item
        workoutDaysArray[0] = workoutObj
    }
    
    
    /*
     * Create Button Function
     *
     * Un-Wrapped function for the create button
     * Creates the # of day's amount of workout objects and adds them
     * to the table. Each one is unique.
     */
    func createButtonFunc() {
        // Add stuff to table
        let numOfDays = Int(numDaysOfWeekTextField.text!)!
        
        for n in 0...numOfDays-1 {
            let dayObj = WorkoutDay()
            dayObj.title = "fart\(n)"
            workoutDaysArray.append(dayObj)
        
            let indexPath = IndexPath(row: workoutDaysArray.count - 1, section: 0)
            
            workoutDaysTable.beginUpdates()
            workoutDaysTable.insertRows(at: [indexPath], with: .automatic)
            workoutDaysTable.endUpdates()
            
            //view.endEditing(true)
        }
        
        if let item = itemToEdit {
            item.listOfWorkouts = workoutDaysArray
        } else {
            globalTemplateItem?.listOfWorkouts = workoutDaysArray
        }
    }
    
    
    /*
     * View Did Load
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        print("segue")
        workoutDaysTable.tableFooterView = UIView(frame: CGRect.zero)
        
        wendlerData = getWendlerData()
        createPickers()
        createToolbarDoneButton()
        
        // itemToEdit passed by prepare segeue from parent.
        // This checks if its nil. If its not, its an edit segeue
        if let item = itemToEdit {
            title = "Edit Template"
            templateTitleTextField.text = item.templateTitle
            numDaysOfWeekTextField.text = String(item.numDaysOfWeek)
            numOfWeeksTextField.text = String(item.numOfWeeks)
            
            if item.wendlerYesNo {
                wendlerTextField.text = "Yes"
            } else {
                wendlerTextField.text = "No"
            }
            
            doneButtonOutlet.isEnabled = true
        } else {
            globalTemplateItem = templateList?.newTemplate()
        }
        
        navigationItem.largeTitleDisplayMode = .never
        print("segue2")
    }
    

    
    /*
     * Done Button Action Function
     *
     * Un-Wrapped done button action
     */
    func doneButtonActionFunc() {
        if let tempTitleChk = templateTitleTextField.text, let daysChk = numDaysOfWeekTextField.text, let wenChk = wendlerTextField.text, let weeksChk = numOfWeeksTextField.text {
                    if (checkForGoodInput(tempTitleChk, daysChk, weeksChk, wenChk)) {
                        return
                    }
                }
                
                returnToDefaultTextField(numDaysOfWeekTextField)
                returnToDefaultTextField(numOfWeeksTextField)
                returnToDefaultTextField(wendlerTextField)
                
                
                if let item = itemToEdit, let tempTitle = templateTitleTextField.text, let days = numDaysOfWeekTextField.text, let wen = wendlerTextField.text, let weeks = numOfWeeksTextField.text  {
                    
                    item.templateTitle = tempTitle
                    item.numOfWeeks = Int(weeks) ?? 0
                    item.numDaysOfWeek = Int(days) ?? 0

                    if (wen == "Yes") {
                        item.wendlerYesNo = true
                    } else {
                        item.wendlerYesNo = false
                    }
                    
                    delegate?.itemDetailViewController(self, didFinishEditing: item)
                    
                } else {
                    
                        if let tempTitle = templateTitleTextField.text, let days = numDaysOfWeekTextField.text, let wen = wendlerTextField.text, let weeks = numOfWeeksTextField.text {
                            
                            globalTemplateItem?.templateTitle = tempTitle
                            globalTemplateItem?.numOfWeeks = Int(weeks) ?? 0
                            globalTemplateItem?.numDaysOfWeek = Int(days) ?? 0
                            
                            if (wen == "Yes") {
                                globalTemplateItem?.wendlerYesNo = true
                            } else {
                                globalTemplateItem?.wendlerYesNo = false
                            }
                        }

                        //item.checked = false
                    delegate?.itemDetailViewController(self, didFinishAdding: globalTemplateItem!)
        //            if let item = templateList?.newTemplate() {
        //
        //                if let tempTitle = templateTitleTextField.text, let days = numDaysOfWeekTextField.text, let wen = wendlerTextField.text, let weeks = numOfWeeksTextField.text {
        //
        //                    item.templateTitle = tempTitle
        //                    item.numOfWeeks = Int(weeks) ?? 0
        //                    item.numDaysOfWeek = Int(days) ?? 0
        //
        //                    if (wen == "Yes") {
        //                        item.wendlerYesNo = true
        //                    } else {
        //                        item.wendlerYesNo = false
        //                    }
        //                }
        //
        //                //item.checked = false
        //                delegate?.itemDetailViewController(self, didFinishAdding: item)
        //            }
                }
    }
    
    
    /*
     * Different segue changes depending on segue identifier
     * This allows 2 different buttons to open the same VC
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {


        if segue.identifier == "workoutDaySegue" {

            if let workoutDayCreation_VC = segue.destination as? WorkoutDayCreation_VC {
                
                // Just passing the first one for now
                let ex1 = Exercise(name: "Bench", isWendler: true)
                let ex2 = Exercise(name: "Bench", isWendler: true)
                let ex3 = Exercise(name: "Bench", isWendler: true)
                
                workoutDaysArray[0].addExercise(ex: ex1)
                workoutDaysArray[0].addExercise(ex: ex2)
                workoutDaysArray[0].addExercise(ex: ex3)
                
                workoutDayCreation_VC.workoutObj = workoutDaysArray[0]
            
                workoutDayCreation_VC.delegate = self
            }
        }
        
//        else if segue.identifier == "EditItemSegue" {
//
//            if let workoutDayCreation_VC = segue.destination as? WorkoutDayCreation_VC {
//
//
//                if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
//
//
//
//                    let item = templateList.templates[indexPath.row]
//                    workoutDayCreation_VC.itemToEdit = item
//
//
//
//                    workoutDayCreation_VC.delegate = self
//                }
//            }
//
//        }
    }
}

extension AddEditTemplate_VC {
    
    /*
     * Return to Default Text Field
     */
    func returnToDefaultTextField(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 5
    }
    
    
    /*
     * Shake and Red Text Field
     */
    func shakeAndRedTextField(_ textField: UITextField) {
        let redColor = UIColor.red
        textField.shake()
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = redColor.cgColor
    }
    
    
    /*
     * Create Pickers
     */
    func createPickers() {
        wendlerPicker.delegate = self
        wendlerTextField.inputView = wendlerPicker
    }
    
    
    /*
     * Create Tool Bar Done Button
     */
    func createToolbarDoneButton() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(AETdoneButtonAction))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        wendlerTextField.inputAccessoryView = toolBar
        //exerciseTextField.inputAccessoryView = toolBar
    }
    
    
    /*
     * Check for Good Input
     */
    func checkForGoodInput(_ tempTitle: String, _ days: String, _ weeks: String, _ wen: String) -> Bool {
        if (tempTitle == "" || weeks == "" || !weeks.isInt || days == "" || !days.isInt || wen == "") {
            
            if (tempTitle == "") {
                shakeAndRedTextField(templateTitleTextField)
            } else {
                returnToDefaultTextField(templateTitleTextField)
            }
            
            if (weeks == "" || !weeks.isInt) {
                shakeAndRedTextField(numOfWeeksTextField)
            } else {
                returnToDefaultTextField(numOfWeeksTextField)
            }
            
            if (days == "" || !days.isInt) {
                shakeAndRedTextField(numDaysOfWeekTextField)
            } else {
                returnToDefaultTextField(numDaysOfWeekTextField)
            }
            
            if (!(wen.lowercased() == "yes" || wen.lowercased() == "no")) {
                shakeAndRedTextField(wendlerTextField)
            } else {
                returnToDefaultTextField(wendlerTextField)
            }
            
            return true
        }
        return false
    }
    
    
    /*
     * Done Button Action for Toolbar
     */
    @objc func AETdoneButtonAction() {
        /*if bodyPartTextField.isEditing {
            bodyPartTextField.resignFirstResponder()
            exerciseTextField.becomeFirstResponder()
        } else if exerciseTextField.isEditing {
            exerciseTextField.resignFirstResponder()
            wendlerTextField.becomeFirstResponder()
        } else*/
        
        if wendlerTextField.isEditing {
            // Add to DB here
            self.view.endEditing(true)
        }
    }
    
    
    /*
     * Get Wendler Data for Picker
     */
    func getWendlerData() -> [String] {
        return ["Yes", "No"]
    }
    
    
    /*
     * Show keyboard automatically without tapping
     */
    override func viewWillAppear(_ animated: Bool) {
            
    //        if itemToEdit != nil {
    //            return
    //        }
        templateTitleTextField.becomeFirstResponder()
    }
}



extension UIView {
    
    /*
     * Shake the textfield for wrong input
     */
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}

extension String {
    
    /*
     * Check if string is typeof(Int)
     */
    var isInt: Bool {
        return Int(self) != nil
    }
}

extension AddEditTemplate_VC: UITextFieldDelegate {
    
    // Tapping done button makes keyboard go away
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    // When user taps a key on a keyboard, this method is called
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Makes it so add button is grayed out unless text is present in textfield
        // Make sure to make add button disabled in attributes inspector
        guard let oldText = textField.text,
            let stringRange = Range(range, in: oldText) else {
                return false
        }
        
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        if newText.isEmpty {
            doneButtonOutlet.isEnabled = false
        } else {
            doneButtonOutlet.isEnabled = true
        }
        return true
    }
}


/*
 * Picker Delegate and Datasource
 */
extension AddEditTemplate_VC: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var returnInt = 0
        
        if pickerView == wendlerPicker {
            returnInt = wendlerData.count
        }
        
        return returnInt
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        var returnStr = ""
        
        if pickerView == wendlerPicker {
            returnStr = wendlerData[row]
        }
        
        return returnStr
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == wendlerPicker {
            selectedWendler = wendlerData[row]
            wendlerTextField.text = selectedWendler
        }
    }
}


/*
 * TableView Delegate and Data Source
 */
extension AddEditTemplate_VC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutDaysArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weightForCell = workoutDaysArray[indexPath.row].title
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutDay") as! workoutDaysInTemplate_TVCell
        cell.cellLabel.text = weightForCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            workoutDaysArray.remove(at: indexPath.row)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
}

//// Delegate from the item detail VC
//extension AddEditTemplate_VC: WorkoutDayCreation_Delegate {
//
//    /*
//     * Cancel button will pop the view controller
//     */
//    func itemDetailViewControllerDidCancel(_ controller: AddEditTemplate_VC) {
//        navigationController?.popViewController(animated: true)
//    }
//
//    /*
//     *
//     */
//    func itemDetailViewController(_ controller: AddEditTemplate_VC, didFinishAdding item: TemplateItem) {
// navigationController?.popViewController(animated: true)
//        let rowIndex = (templateList?.templates.count)! - 1
//        let indexPath = IndexPath(row: rowIndex, section: 0)
//        let indexPaths = [indexPath]
//        tableView.insertRows(at: indexPaths, with: .automatic)
//    }
//
//
//    /*
//     *
//     */
//    func itemDetailViewController(_ controller: AddEditTemplate_VC, didFinishEditing item: TemplateItem) {
//        if let index = templateList?.templates.firstIndex(of: item) {
//            let indexPath = IndexPath(row: index, section: 0)
//            if let cell = tableView.cellForRow(at: indexPath) {
//                configureText(for: cell, with: item)
//            }
//        }
//        navigationController?.popViewController(animated: true)
//    }
//}


