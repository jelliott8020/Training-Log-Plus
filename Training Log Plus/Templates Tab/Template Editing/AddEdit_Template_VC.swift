//
//  AddItemTableViewController.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 9/8/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit


protocol Pass_AddEditTemplate_BackTo_TemplateParent_Delegate: class {
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
class AddEdit_Template_VC: UIViewController {
    
    
    // In order to use the protocol above, need a delegate
    // Any viewController that implements this protocol can be a delegate of the AddItemTableViewController
    weak var delegate: Pass_AddEditTemplate_BackTo_TemplateParent_Delegate?
    weak var templateList: TemplateList?
    weak var itemToEdit: Template?
    weak var globalTemplateItem: Template?
    
    var passedTitle: String?
    var passedDays: Int?
    var passedWen: Bool?
    var passedWeeks: Int?
    
    var wendlerPicker = UIPickerView()
    var wendlerData: [String] = []
    var selectedWendler: String?
    
    var alertName: String?
    
    var workoutDaysList: WorkoutList
    
    @IBOutlet weak var doneButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var workoutDaysTable: UITableView!
    @IBOutlet weak var templateNameLabel: UILabel!
    @IBOutlet weak var numDaysLabel: UILabel!
    @IBOutlet weak var wendlerLabel: UILabel!
    @IBOutlet weak var numWeeksLabel: UILabel!
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    @IBAction func doneButtonAction(_ sender: UIBarButtonItem) {
        // Account for editing
        doneButtonActionFunc()
    }
    
    
    /*
     * Initializer
     */
    required init?(coder aDecoder: NSCoder) {
        workoutDaysList = WorkoutList()
        super.init(coder: aDecoder)
    }
    
    
    /*
     * View Did Load
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = passedTitle
        
        workoutDaysTable.tableFooterView = UIView(frame: CGRect.zero)
        
        wendlerData = Util.getYesOrNoForPickerData()
        //createPickers()
        //createToolbarDoneButton()
        
        // If its an item thats passed (itemToEdit), fill in data
        // Else create a new TemplateItem
        if let item = itemToEdit {
            self.title = item.title
            
            setLabels(title: item.title, days: String(item.numDaysOfWeek), wen: item.wendlerYesNo, weeks: String(item.numOfWeeks))
            
            workoutDaysList = item.workoutList
            
            doneButtonOutlet.isEnabled = true
        } else {
            
            if let title = passedTitle, let wen = passedWen, let weeks = passedWeeks, let days = passedDays {
                globalTemplateItem = templateList?.newTemplate()
                globalTemplateItem?.numOfWeeks = weeks
                globalTemplateItem?.numDaysOfWeek = days
                globalTemplateItem?.wendlerYesNo = wen
                globalTemplateItem?.title = title
                
                self.title = title
                
                
                for _ in 1...days {
                    let newWorkout = WorkoutDay()
                    newWorkout.setTitle("Tap to edit")
                    globalTemplateItem?.workoutList.addWorkoutObj(newWorkout)
                    workoutDaysList.addWorkoutObj(newWorkout)
                }
                
                setLabels(title: passedTitle!, days: String(passedDays!), wen: passedWen!, weeks: String(passedWeeks!))
            }
        }
        
        navigationItem.largeTitleDisplayMode = .never
    }
    
    
    /*
     * Set Text Fields
     *
     * Sets the text field's values with the object passed
     */
    func setLabels(title: String, days: String, wen: Bool, weeks: String) {
        templateNameLabel.text = title
        numDaysLabel.text = days
        numWeeksLabel.text = weeks
        
        if wen {
            wendlerLabel.text = "Yes"
        } else {
            wendlerLabel.text = "No"
        }
    }
    
    
    /*
     * Pass Workout Object Back
     *
     * Protocol function, receives the object from WorkoutDayCreation_VC
     */
    func passWorkoutObjBack(workoutObj: WorkoutDay) {
        
        // Just replacing the first item
        workoutDaysList.addWorkoutObj(workoutObj)
        workoutDaysTable.reloadData()
        
    }
    
    func addButtonAlert() {
        //Step : 1
        let alert = UIAlertController(title: "Workout Name", message: "", preferredStyle: UIAlertController.Style.alert )
        
        //Step : 2
        let save = UIAlertAction(title: "Create", style: .default) { (alertAction) in
            
            let workoutNameTxtField = alert.textFields![0] as UITextField
            
            if let name = workoutNameTxtField.text {
                
//                var check = Util.checkForBlankInput(str: title, txtField: self.tempNameTxtField!)
//                check = Util.checkForBlankInput(str: days, txtField: self.numDaysTxtField!)
//                check = Util.checkForBlankInput(str: wen, txtField: self.wendlerYesNoTxtField!)
//                check = Util.checkForBlankInput(str: weeks, txtField: self.numWeeksTxtField!)
                
                self.alertName = name
//                if (check) {
//                    return
//                }
                
                self.performSegue(withIdentifier: "workoutDaySegue", sender: self)
            }
        }
        
        //let toolBar = createToolbarDoneButton()
        
        alert.addTextField { (workoutNameTxtField) in
            workoutNameTxtField.placeholder = " Workout Name:"
            //tempNameTxtField.inputAccessoryView = toolBar
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (alertAction) in }
        
        alert.addAction(save)
        alert.addAction(cancel)
        
        self.present(alert, animated:true, completion: nil)
        
    }
    
    
//    /*
//     * Create Button Function
//     *
//     * Creates the # of day's amount of workout objects and adds them
//     * to the table. Each one is unique.
//     */
//    func createButtonFunc() {
//        let numOfDays = passedDays
//
//        for _ in 0...numOfDays-1 {
//            let dayObj = WorkoutDay()
//            workoutDaysList.addWorkoutObj(dayObj)
//
//            let indexPath = IndexPath(row: workoutDaysList.workouts.count - 1, section: 0)
//
//            workoutDaysTable.beginUpdates()
//            workoutDaysTable.insertRows(at: [indexPath], with: .automatic)
//            workoutDaysTable.endUpdates()
//
//            //view.endEditing(true)
//        }
//
//        if let item = itemToEdit {
//            item.workoutList = workoutDaysList
//        } else {
//            globalTemplateItem?.workoutList = workoutDaysList
//        }
//    }
    
    
    /*
     * Done Button Function
     *
     * Checks for good input
     * If its an itemToEdit, update that
     * Else, fill in the new item's information
     */
    func doneButtonActionFunc() {
//        if let tempTitleChk = templateTitleTextField.text, let daysChk = numDaysOfWeekTextField.text, let wenChk = wendlerTextField.text, let weeksChk = numOfWeeksTextField.text {
//
//            var check = false
//
//            check = Util.checkForBlankInput(str: tempTitleChk, txtField: templateTitleTextField)
//            check = Util.checkForBlankInput(str: daysChk, txtField: numDaysOfWeekTextField)
//            check = Util.checkForBlankInput(str: weeksChk, txtField: numOfWeeksTextField)
//            check = Util.checkForBlankInput(str: wenChk, txtField: wendlerTextField)
//
//            if (check) {
//                return
//            }
            
            if let item = itemToEdit/*, let tempTitle = templateTitleTextField.text, let days = numDaysOfWeekTextField.text, let wen = wendlerTextField.text, let weeks = numOfWeeksTextField.text  */{
                
                /*item.title = tempTitle
                item.numOfWeeks = Int(weeks) ?? 0
                item.numDaysOfWeek = Int(days) ?? 0
                
                if (wen == "Yes") {
                    item.wendlerYesNo = true
                } else {
                    item.wendlerYesNo = false
                }*/
                
                delegate?.itemDetailViewController(self, didFinishEditing: item)
                
            } else {
                
                /*if let tempTitle = templateTitleTextField.text, let days = numDaysOfWeekTextField.text, let wen = wendlerTextField.text, let weeks = numOfWeeksTextField.text {
                    
                    globalTemplateItem?.title = tempTitle
                    globalTemplateItem?.numOfWeeks = Int(weeks) ?? 0
                    globalTemplateItem?.numDaysOfWeek = Int(days) ?? 0
                    
                    if (wen == "Yes") {
                        globalTemplateItem?.wendlerYesNo = true
                    } else {
                        globalTemplateItem?.wendlerYesNo = false
                    }
                }*/
                
                delegate?.itemDetailViewController(self, didFinishAdding: globalTemplateItem!)
            }
        //}
    }
    
    
    /*
     * Prepare For Segue
     *
     * When opening up segue, passes information to the new VC
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        if segue.identifier == "workoutDaySegue" {
            
            if let workoutDayCreation_VC = segue.destination as? WorkoutDayCreation_VC {
                if let cell = sender as? UITableViewCell, let indexPath = workoutDaysTable.indexPath(for: cell) {
                    
                    let item = workoutDaysList.workouts[indexPath.row]
                    workoutDayCreation_VC.workoutObj = item
                    //workoutDayCreation_VC.passedTitle = alertName
                    workoutDayCreation_VC.delegate = self
                }
            }
        }
    }
    
    /*
     * Configure the text for each row item.
     */
    func configureText(for cell: UITableViewCell, with item: WorkoutDay) {
        if let templateCell = cell as? workoutDaysInTemplate_TVCell {
            templateCell.cellLabel.text = item.title
        }
    }
}

/*
 * Delegate
 *
 * Implements the functions that allow the New or Edited Template to be passed back
 */
extension AddEdit_Template_VC: Pass_WorkoutDayObject_BackTo_AddEditTemplate_Delegate {
    
    /*
     * Cancel button will pop the view controller
     */
    func workoutDayObject_DidCancel(_ controller: WorkoutDayCreation_VC) {
        navigationController?.popViewController(animated: true)
    }
    
    
    /*
     * After adding, data is passed back
     */
    func workoutDayObjectCreation_PassTo_AddEditTemplate(_ controller: WorkoutDayCreation_VC, didFinishAdding item: WorkoutDay) {
        //navigationController?.popViewController(animated: true)
        workoutDaysList.addWorkoutObj(item)
        let rowIndex = workoutDaysList.workouts.count - 1
        let indexPath = IndexPath(row: rowIndex, section: 0)
        workoutDaysTable.insertRows(at: [indexPath], with: .automatic)
    }
    
    
    /*
     * After editing, data is passed back
     */
    func workoutDayObjectCreation_PassTo_AddEditTemplate(_ controller: WorkoutDayCreation_VC, didFinishEditing item: WorkoutDay) {
        if let index = workoutDaysList.workouts.firstIndex(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = workoutDaysTable.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
        }
        //navigationController?.popViewController(animated: true)
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
 * TableView
 */
extension AddEdit_Template_VC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutDaysList.workouts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weightForCell = workoutDaysList.workouts[indexPath.row].title
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutDay") as! workoutDaysInTemplate_TVCell
        
        cell.cellLabel.text = weightForCell
        
        if weightForCell == "Tap to Edit" {
            cell.cellLabel.textColor = .gray
        }
        return cell
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//
//        addButtonAlert()
//    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            workoutDaysList.workouts.remove(at: indexPath.row)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
}


