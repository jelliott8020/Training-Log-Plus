//
//  AddItemTableViewController.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 9/8/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit


protocol AddEdit_Template_VC_Delegate: class {
    // User hit cancel
    func itemDetailViewControllerDidCancel(_ controller: AddEdit_Template_VC)
    // User added item
    func itemDetailViewController(_ controller: AddEdit_Template_VC, didFinishAdding item: Template)
    // User finishes editing
    func itemDetailViewController(_ controller: AddEdit_Template_VC, didFinishEditing item: Template)
}


/*
 * This class allows 2 views, an Add and Edit
 */
class AddEdit_Template_VC: UIViewController, WorkoutDayCreation_VC_Delegate {
    
    
    // In order to use the protocol above, need a delegate
    // Any viewController that implements this protocol can be a delegate of the AddItemTableViewController
    weak var delegate: AddEdit_Template_VC_Delegate?
    weak var templateList: TemplateList?
    weak var itemToEdit: Template?
    weak var globalTemplateItem: Template?
    
    var wendlerPicker = UIPickerView()
    var wendlerData: [String] = []
    var selectedWendler: String?
    var workoutDaysArray: [WorkoutDay] = []
    
    @IBOutlet weak var doneButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var templateTitleTextField: UITextField!
    @IBOutlet weak var numDaysOfWeekTextField: UITextField!
    @IBOutlet weak var wendlerTextField: UITextField!
    @IBOutlet weak var numOfWeeksTextField: UITextField!
    @IBOutlet weak var workoutDaysTable: UITableView!
    
    @IBAction func createButton(_ sender: UIButton) {
        createButtonFunc()
    }
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    @IBAction func doneButtonAction(_ sender: UIBarButtonItem) {
        // Account for editing
        doneButtonActionFunc()
    }
    
    
    /*
     * View Did Load
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        workoutDaysTable.tableFooterView = UIView(frame: CGRect.zero)
        
        wendlerData = Util.getYesOrNoForPickerData()
        createPickers()
        createToolbarDoneButton()
        
        // If its an item thats passed (itemToEdit), fill in data
        // Else create a new TemplateItem
        if let item = itemToEdit {
            title = "Edit Template"
            templateTitleTextField.text = item.title
            numDaysOfWeekTextField.text = String(item.numDaysOfWeek)
            numOfWeeksTextField.text = String(item.numOfWeeks)
            
            if item.wendlerYesNo {
                wendlerTextField.text = "Yes"
            } else {
                wendlerTextField.text = "No"
            }
            
            workoutDaysArray = item.listOfWorkouts
            
            doneButtonOutlet.isEnabled = true
        } else {
            globalTemplateItem = templateList?.newTemplate()
        }
        
        navigationItem.largeTitleDisplayMode = .never
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
        workoutDaysTable.reloadData()
        
    }
    
    
    /*
     * Create Button Function
     *
     * Creates the # of day's amount of workout objects and adds them
     * to the table. Each one is unique.
     */
    func createButtonFunc() {
        let numOfDays = Int(numDaysOfWeekTextField.text!)!
        
        for n in 0...numOfDays-1 {
            let dayObj = WorkoutDay(title: "fart\(n)")
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
     * Done Button Function
     *
     * Checks for good input
     * If its an itemToEdit, update that
     * Else, fill in the new item's information
     */
    func doneButtonActionFunc() {
        if let tempTitleChk = templateTitleTextField.text, let daysChk = numDaysOfWeekTextField.text, let wenChk = wendlerTextField.text, let weeksChk = numOfWeeksTextField.text {
            
            var check = false
            
            check = Util.checkForBlankInput(str: tempTitleChk, txtField: templateTitleTextField)
            check = Util.checkForBlankInput(str: daysChk, txtField: numDaysOfWeekTextField)
            check = Util.checkForBlankInput(str: weeksChk, txtField: numOfWeeksTextField)
            check = Util.checkForBlankInput(str: wenChk, txtField: wendlerTextField)
            
            if (check) {
                return
            }
            
            if let item = itemToEdit, let tempTitle = templateTitleTextField.text, let days = numDaysOfWeekTextField.text, let wen = wendlerTextField.text, let weeks = numOfWeeksTextField.text  {
                
                item.title = tempTitle
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
                    
                    globalTemplateItem?.title = tempTitle
                    globalTemplateItem?.numOfWeeks = Int(weeks) ?? 0
                    globalTemplateItem?.numDaysOfWeek = Int(days) ?? 0
                    
                    if (wen == "Yes") {
                        globalTemplateItem?.wendlerYesNo = true
                    } else {
                        globalTemplateItem?.wendlerYesNo = false
                    }
                }
                
                delegate?.itemDetailViewController(self, didFinishAdding: globalTemplateItem!)
            }
        }
    }
    
    
    /*
     * Different segue changes depending on segue identifier
     * This allows 2 different buttons to open the same VC
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "workoutDaySegue" {
            
            if let workoutDayCreation_VC = segue.destination as? WorkoutDayCreation_VC {
                workoutDayCreation_VC.workoutObj = workoutDaysArray[0]
                workoutDayCreation_VC.delegate = self
            }
        }
    }
}

extension AddEdit_Template_VC {
    
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
    }
    
    
    /*
     * Done Button Action for Toolbar
     */
    @objc func AETdoneButtonAction() {
        if wendlerTextField.isEditing {
            // Add to DB here
            self.view.endEditing(true)
        }
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


/*
 * TextField
 */
extension AddEdit_Template_VC: UITextFieldDelegate {
    
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
 * Picker
 */
extension AddEdit_Template_VC: UIPickerViewDataSource, UIPickerViewDelegate {
    
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
 * TableView
 */
extension AddEdit_Template_VC: UITableViewDelegate, UITableViewDataSource {
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


