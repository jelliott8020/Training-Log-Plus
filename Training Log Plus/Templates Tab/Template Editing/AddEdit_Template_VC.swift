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
    
    
    weak var delegate: Pass_AddEditTemplate_BackTo_TemplateParent_Delegate?
    var templateList: [Template] = []
    weak var itemToEdit: Template?
    var globalTemplateItem: Template?
    var workoutDaysList: [WorkoutDay] = []
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var passedTitle: String?
    var passedDays: Int?
    var passedWen: Bool?
    var passedWeeks: Int?
    
    var wendlerPicker = UIPickerView()
    var wendlerData: [String] = []
    var selectedWendler: String?
    
    var alertName: String?
    

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
        doneButtonActionFunc()
    }
    
    
    /*
     * Initializer
     */
    required init?(coder aDecoder: NSCoder) {
        //workoutDaysList = WorkoutList()
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
            self.title = item.name
            
            setLabels(title: item.name, days: String(item.numDays), wen: item.wendlerYesNo, weeks: String(item.numOfWeeks))
            
            workoutDaysList = item.workoutList?.allObjects as! [WorkoutDay]
            
            doneButtonOutlet.isEnabled = true
        } else {
            
            if let title = passedTitle, let wen = passedWen, let weeks = passedWeeks, let days = passedDays {
                globalTemplateItem = Template(entity: Template.entity(), insertInto: context)
                globalTemplateItem!.numWeeks = weeks
                globalTemplateItem!.numDays = days
                globalTemplateItem!.wendlerYesNo = wen
                globalTemplateItem!.name = title
                
                templateList.append(globalTemplateItem!)
                
                self.title = title
                
                
                for _ in 0...days-1 {
                    let newWorkout = WorkoutDay(entity: WorkoutDay.entity(), insertInto: context)
                    newWorkout.name = "Tap to edit"
                    globalTemplateItem?.addToWorkoutList(newWorkout)
                    workoutDaysList.append(newWorkout)
                }
                
                setLabels(title: passedTitle!, days: String(passedDays!), wen: passedWen!, weeks: String(passedWeeks!))
            }
        }
        
        navigationItem.largeTitleDisplayMode = .never
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
        
        appDelegate.saveContext()
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
                    
                    let item = workoutDaysList[indexPath.row]
                    workoutDayCreation_VC.passedInWorkoutObj = item
                    workoutDayCreation_VC.delegate = self
                    appDelegate.saveContext()
                }
            }
        }
    }
    

}


/**
 * PASSBACK DELEGATE
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
        workoutDaysList.append(item)
        let rowIndex = workoutDaysList.count - 1
        let indexPath = IndexPath(row: rowIndex, section: 0)
        workoutDaysTable.insertRows(at: [indexPath], with: .automatic)
    }
    
    
    /*
     * After editing, data is passed back
     */
    func workoutDayObjectCreation_PassTo_AddEditTemplate(_ controller: WorkoutDayCreation_VC, didFinishEditing item: WorkoutDay) {
        if let index = workoutDaysList.firstIndex(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = workoutDaysTable.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
        }
        //navigationController?.popViewController(animated: true)
    }
}


/**
 * TEXTFIELD
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


/**
 * TABLE VIEW
 */
extension AddEdit_Template_VC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutDaysList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weightForCell = workoutDaysList[indexPath.row].name
        
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
    
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        
//        if editingStyle == .delete {
//            workoutDaysList.remove(at: indexPath.row)
//            
//            tableView.beginUpdates()
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//            tableView.endUpdates()
//        }
//    }
}


/**
 * UTILITY FUNCTIONS
 */
extension AddEdit_Template_VC {
    
    /*
     * Configure the text for each row item.
     */
    func configureText(for cell: UITableViewCell, with item: WorkoutDay) {
        if let templateCell = cell as? workoutDaysInTemplate_TVCell {
            templateCell.cellLabel.text = item.name
        }
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
}


