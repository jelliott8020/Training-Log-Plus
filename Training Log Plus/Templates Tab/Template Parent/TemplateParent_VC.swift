//
//  TemplatesTableViewController.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 9/6/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit
import CoreData

class TemplateParent_VC: UITableViewController {
    
    // Eventually this will become a [Template] where the init
    // queries Core Data and fills it
    //var templateList: TemplateList
    var templateList: [Template] = []
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var alertTitle: String?
    var alertDays: Int?
    var alertWen: Bool?
    var alertWeeks: Int?
    
    //var wendlerPicker = UIPickerView()
    //var wendlerData: [String] = []
    var selectedWendler: String?
    
    var tempNameTxtField: UITextField?
    var numDaysTxtField: UITextField?
    var wendlerYesNoTxtField: UITextField?
    var numWeeksTxtField: UITextField?
    
    /*
     * Initializer
     */
    required init?(coder aDecoder: NSCoder) {
        //templateList = TemplateList()
        
        
        super.init(coder: aDecoder)
    }
    
    func refreshTemplateData() {
        
        let request = Template.fetchRequest() as NSFetchRequest<Template>
        
        do {
            templateList = try context.fetch(request)
        } catch let error as NSError {
            print("Could no fetch templateData. \(error), \(error.userInfo)")
        }
        
        tableView.reloadData()
    }
    
    
    /*
     * View Did Load
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshTemplateData()
        //wendlerData = Util.getYesOrNoForPickerData()
        //self.wendlerPicker.delegate = self
    }
    
    
    @IBAction func addTemplateButton(_ sender: UIBarButtonItem) {
        addButtonAlert()
    }
    
    @IBAction func createTestData(_ sender: UIBarButtonItem) {
        createTestData()
    }
    
    /*
     * When user interacts with cell
     */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let alert = UIAlertController(title:  "Are you sure?", message: "", preferredStyle: .alert)
            
            let noButton = UIAlertAction(title: "No", style: UIAlertAction.Style.destructive, handler: nil)
            let yesButton = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { (action) -> Void in
                self.templateList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                
            } )
            
            alert.addAction(yesButton)
            alert.addAction(noButton)
            
            present(alert, animated: true, completion: nil)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    /*
     * Tell the table how many cells to display
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return templateList.count
    }
    
    
    /*
     * Called everytime a table needs a cell
     * Configure cell to show certain data
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TemplateCell", for: indexPath)
        
        // Manipulating the data on the label in the cell
        let item = templateList[indexPath.row]
        configureText(for: cell, with: item)
        
        //configureCheckmark(for: cell, with: item)
        
        return cell
    }
    
    
    func addButtonAlert() {
        //Step : 1
        let alert = UIAlertController(title: "Create Template", message: "Table Information", preferredStyle: UIAlertController.Style.alert )
        
        
        
        
        //Step : 2
        let save = UIAlertAction(title: "Create", style: .default) { (alertAction) in
            
            self.tempNameTxtField = alert.textFields![0] as UITextField
            self.numDaysTxtField = alert.textFields![1] as UITextField
            self.wendlerYesNoTxtField = alert.textFields![2] as UITextField
            self.numWeeksTxtField = alert.textFields![3] as UITextField
            
            if let title = self.tempNameTxtField?.text, let days = self.numDaysTxtField?.text, let wen = self.wendlerYesNoTxtField?.text, let weeks = self.numWeeksTxtField?.text {
                
                if (Util.checkForBlankInput(str: title, txtField: self.tempNameTxtField!)) {return}
                if (Util.checkForBlankInput(str: days, txtField: self.numDaysTxtField!)) {return}
                if (Util.checkForBlankInput(str: wen, txtField: self.wendlerYesNoTxtField!)) {return}
                if (Util.checkForBlankInput(str: weeks, txtField: self.numWeeksTxtField!)) {return}
                
                if Int(days)! <= 1 {
                    let alert = UIAlertController(title: "Invalid entry", message: "Days less than 1", preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "Ok", style: .default) { (alertAction) in self.addButtonAlert()}
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                    
                }
                
                self.alertTitle = title
                self.alertDays = Int(days)
                self.alertWeeks = Int(weeks)
                
                if (wen.lowercased() == "yes") {
                    self.alertWen = true
                } else {
                    self.alertWen = false
                }
                
                self.performSegue(withIdentifier: "AddItemSegue", sender: self)
            }
        }
        
        //let toolBar = createToolbarDoneButton()
        
        alert.addTextField { (tempNameTxtField) in
            tempNameTxtField.placeholder = "Template Title:"
            //tempNameTxtField.inputAccessoryView = toolBar
        }
        
        alert.addTextField { (numDaysTxtField) in
            numDaysTxtField.placeholder = "Number of Days per Week:"
            numDaysTxtField.keyboardType = UIKeyboardType.numberPad
            //numDaysTxtField.inputAccessoryView = toolBar
        }
        
        alert.addTextField { (wendlerYesNoTxtField) in
            wendlerYesNoTxtField.placeholder = "Will there be Wendler Progression?"
            //wendlerYesNoTxtField.inputView = self.wendlerPicker
            //wendlerYesNoTxtField.inputAccessoryView = toolBar
        }
        
        alert.addTextField { (numWeeksTxtField) in
            numWeeksTxtField.placeholder = "Number of Weeks"
            numWeeksTxtField.keyboardType = UIKeyboardType.numberPad
            //numWeeksTxtField.inputAccessoryView = toolBar
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (alertAction) in }
        
        alert.addAction(save)
        alert.addAction(cancel)
        
        self.present(alert, animated:true, completion: nil)
        
    }
    
    
    /*
     * Prepare For Segue
     *
     * Different segue changes depending on segue identifier.
     * This allows 2 different buttons to open the same VC.
     * If editing, pass the item. If adding, will create new item there.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItemSegue" {
            if let addTempVC = segue.destination as? AddEdit_Template_VC {
                addTempVC.delegate = self
                addTempVC.templateList = templateList
                addTempVC.passedTitle = alertTitle
                addTempVC.passedWen = alertWen
                addTempVC.passedDays = alertDays
                addTempVC.passedWeeks = alertWeeks
            }
        } else if segue.identifier == "EditItemSegue" {
            if let editTempVC = segue.destination as? AddEdit_Template_VC {
                if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                    let item = templateList[indexPath.row]
                    editTempVC.itemToEdit = item
                    editTempVC.delegate = self
                }
            }
        }
    }
    
    
    /*
     * Configure the text for each row item.
     */
    func configureText(for cell: UITableViewCell, with item: Template) {
        if let templateCell = cell as? Template_TVCell {
            templateCell.templateTextLabel.text = item.name
        }
    }
    
    
    /*
     * Changes the top bar to white (battery, service provider)
     * Doesn't work for some reason
     */
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
}


/*
 * Delegate
 *
 * Implements the functions that allow the New or Edited Template to be passed back
 */
extension TemplateParent_VC: Pass_AddEditTemplate_BackTo_TemplateParent_Delegate {
    
    /*
     * Cancel button will pop the view controller
     */
    func itemDetailViewControllerDidCancel(_ controller: AddEdit_Template_VC) {
        navigationController?.popViewController(animated: true)
    }
    
    
    /*
     * After adding, data is passed back
     */
    func itemDetailViewController(_ controller: AddEdit_Template_VC, didFinishAdding item: Template) {
        navigationController?.popViewController(animated: true)
        templateList.append(item)
        let rowIndex = templateList.count - 1
        let indexPath = IndexPath(row: rowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    
    /*
     * After editing, data is passed back
     */
    func itemDetailViewController(_ controller: AddEdit_Template_VC, didFinishEditing item: Template) {
        if let index = templateList.firstIndex(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
        }
        navigationController?.popViewController(animated: true)
    }
}

/*
 * Utility Functions
 */
extension TemplateParent_VC {
    
    
    func createTestData() {
        
        // Create Template
        let temp1 = getNewTemplate("Template Title 1")
        
        // Create WorkoutDay
        let wo1 = getNewWorkoutDay("Tester1")
        
        
        // WENDLER EXERCISES
        let ex1 = getNewWenExercise("Bench")
        ex1.bodyPart = "Chest"
        ex1.progression = "531"
        let ex1TM1 = getNewWendlerTM()
        let ex1PR1 = getNewWendlerPR()
        let ex1TM2 = getNewWendlerTM()
        let ex1PR2 = getNewWendlerPR()
        ex1.addToPersonalRecords(ex1PR1)
        ex1.addToPersonalRecords(ex1PR2)
        ex1.addToTrainingMaxes(ex1TM1)
        ex1.addToTrainingMaxes(ex1TM2)
        
        let ex2 = getNewWenExercise("Squatter")
        ex2.bodyPart = "Legs"
        ex2.progression = "531"
        let ex2TM1 = getNewWendlerTM()
        let ex2PR1 = getNewWendlerPR()
        let ex2TM2 = getNewWendlerTM()
        let ex2PR2 = getNewWendlerPR()
        ex2.addToPersonalRecords(ex2PR1)
        ex2.addToPersonalRecords(ex2PR2)
        ex2.addToTrainingMaxes(ex2TM1)
        ex2.addToTrainingMaxes(ex2TM2)
        
        let ex3 = getNewWenExercise("Dead")
        ex3.bodyPart = "Back"
        ex3.progression = "Starting Strength"
        let ex3TM1 = getNewWendlerTM()
        let ex3PR1 = getNewWendlerPR()
        let ex3TM2 = getNewWendlerTM()
        let ex3PR2 = getNewWendlerPR()
        ex3.addToPersonalRecords(ex3PR1)
        ex3.addToPersonalRecords(ex3PR2)
        ex3.addToTrainingMaxes(ex3TM1)
        ex3.addToTrainingMaxes(ex3TM2)
  
        let ex4 = getNewWenExercise("DB Bench")
        ex4.bodyPart = "Chest"
        ex4.progression = "531"
        let ex4TM1 = getNewWendlerTM()
        let ex4PR1 = getNewWendlerPR()
        let ex4TM2 = getNewWendlerTM()
        let ex4PR2 = getNewWendlerPR()
        ex4.addToPersonalRecords(ex4PR1)
        ex4.addToPersonalRecords(ex4PR2)
        ex4.addToTrainingMaxes(ex4TM1)
        ex4.addToTrainingMaxes(ex4TM2)
        
        
        // BB EXERCISES
        let ex5 = getNewBBExercise("Incline Bench")
        ex5.bodyPart = "Chest"
        ex5.progression = "531"
        let ex5Att1 = getNewBBAttempt()
        let ex5Att2 = getNewBBAttempt()
        let ex5Att3 = getNewBBAttempt()
        ex5.addToAttemptList(ex5Att1)
        ex5.addToAttemptList(ex5Att2)
        ex5.addToAttemptList(ex5Att3)
        
        let ex6 = getNewBBExercise("Pullup")
        ex6.bodyPart = "Back"
        ex6.progression = "531"
        let ex6Att1 = getNewBBAttempt()
        let ex6Att2 = getNewBBAttempt()
        let ex6Att3 = getNewBBAttempt()
        ex6.addToAttemptList(ex6Att1)
        ex6.addToAttemptList(ex6Att2)
        ex6.addToAttemptList(ex6Att3)
        
        let ex7 = getNewBBExercise("Row")
        ex7.bodyPart = "Back"
        ex7.progression = "531"
        let ex7Att1 = getNewBBAttempt()
        let ex7Att2 = getNewBBAttempt()
        let ex7Att3 = getNewBBAttempt()
        ex7.addToAttemptList(ex7Att1)
        ex7.addToAttemptList(ex7Att2)
        ex7.addToAttemptList(ex7Att3)
        
        let ex8 = getNewBBExercise("Mil Press")
        ex8.bodyPart = "Shoulders"
        ex8.progression = "531"
        let ex8Att1 = getNewBBAttempt()
        let ex8Att2 = getNewBBAttempt()
        let ex8Att3 = getNewBBAttempt()
        ex8.addToAttemptList(ex8Att1)
        ex8.addToAttemptList(ex8Att2)
        ex8.addToAttemptList(ex8Att3)
        
        
        // MAIN EXERCISE
        let mainBB = getNewBBExercise("Main Ex - BB")
        mainBB.bodyPart = "Misc"
        mainBB.progression = "3x10"
        let mainAtt1 = getNewBBAttempt()
        let mainAtt2 = getNewBBAttempt()
        let mainAtt3 = getNewBBAttempt()
        mainBB.addToAttemptList(mainAtt1)
        mainBB.addToAttemptList(mainAtt2)
        mainBB.addToAttemptList(mainAtt3)
        
        let mainWen = getNewWenExercise("OHP")
        mainWen.bodyPart = "Shoulders"
        mainWen.progression = "531"
        let mainWenTM1 = getNewWendlerTM()
        let mainWenPR1 = getNewWendlerPR()
        let mainWenTM2 = getNewWendlerTM()
        let mainWenPR2 = getNewWendlerPR()
        mainWen.addToPersonalRecords(mainWenPR1)
        mainWen.addToPersonalRecords(mainWenPR2)
        mainWen.addToTrainingMaxes(mainWenTM1)
        mainWen.addToTrainingMaxes(mainWenTM2)
        
        // Add Main Exercise to Workout
        wo1.addToMainExerciseList(mainBB)
        wo1.addToMainExerciseList(mainWen)
        
        // Add Accessories to Workout
        wo1.addToAccExerciseList(ex1)
        wo1.addToAccExerciseList(ex2)
        wo1.addToAccExerciseList(ex3)
        wo1.addToAccExerciseList(ex4)
        wo1.addToAccExerciseList(ex5)
        wo1.addToAccExerciseList(ex6)
        wo1.addToAccExerciseList(ex7)
        wo1.addToAccExerciseList(ex8)
        
        // Add Workout to Template
        temp1.addToWorkoutList(wo1)
        
        // Add Template Characterists
        //temp1.numDaysPerWeek = temp1.workoutList?.count
        temp1.numDays = temp1.workoutList?.count ?? 0
        temp1.numOfWeeks = 1
        templateList.append(temp1)
        
        tableView.reloadData()
    }
    
    /********************/
    // Helper Functions //
    /********************/
    func getNewWendlerTM() -> TrainingMax {
        let item = TrainingMax(entity: TrainingMax.entity(), insertInto: context)
        item.date = Date.init()
        item.trainingMax = 335.0
        return item
    }
    
    func getNewWendlerPR() -> PersonalRecord {
        let item = PersonalRecord(entity: PersonalRecord.entity(), insertInto: context)
        item.date = Date.init()
        item.weight = 225.0
        item.reps = 12.0
        return item
    }
    
    func getNewBBAttempt() -> Attempt {
        let item = Attempt(entity: Attempt.entity(), insertInto: context)
        item.date = Date.init()
        
        for _ in 0...3 {
            let set = Sets(entity: Sets.entity(), insertInto: context)
            set.reps = Int32.random(in: 1...12)
            set.weight = Double.random(in: 40...240)
            item.addToSets(set)
        }
        
        return item
    }
    
    func getNewWenExercise(_ name: String) -> Wen_Exercise {
        let item = Wen_Exercise(entity: Wen_Exercise.entity(), insertInto: context)
        item.name = name
        return item
    }
    
    func getNewBBExercise(_ name: String) -> BB_Exercise {
        let item = BB_Exercise(entity: BB_Exercise.entity(), insertInto: context)
        item.name = name
        return item
    }
    
    func getNewWorkoutDay(_ name: String) -> WorkoutDay {
        let item = WorkoutDay(entity: WorkoutDay.entity(), insertInto: context)
        item.name = name
        return item
    }
    
    func getNewTemplate(_ name: String) -> Template {
        let item = Template(entity: Template.entity(), insertInto: context)
        item.name = name
        return item
    }
    
    // END HELPER FUCNTIONS //
    
    
    
    
    
    
    /*
     * Create Tool Bar Done Button
     *
     * Creates done buttons for the toolbars
     */
    func createToolbarDoneButton() -> UIToolbar {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonAction))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    
    
    /*
     * Done Button Action
     *
     * Tells the toolbar what to do when done is tapped
     */
    @objc func doneButtonAction() {
        if tempNameTxtField!.isEditing {
            tempNameTxtField!.resignFirstResponder()
            numDaysTxtField!.becomeFirstResponder()
        } else if numDaysTxtField!.isEditing {
            numDaysTxtField!.resignFirstResponder()
            wendlerYesNoTxtField!.becomeFirstResponder()
        } else if wendlerYesNoTxtField!.isEditing {
            wendlerYesNoTxtField!.resignFirstResponder()
            numWeeksTxtField!.becomeFirstResponder()
        } else if numWeeksTxtField!.isEditing {
            numWeeksTxtField!.resignFirstResponder()
            self.performSegue(withIdentifier: "AddItemSegue", sender: self)
        }
    }
    
    //    /*
    //     * Show keyboard automatically without tapping
    //     */
    //    override func viewWillAppear(_ animated: Bool) {
    //
    //        //        if itemToEdit != nil {
    //        //            return
    //        //        }
    //        templateTitleTextField.becomeFirstResponder()
    //    }
}

///*
// * Picker
// */
//extension TemplateParent_VC: UIPickerViewDataSource, UIPickerViewDelegate {
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        var returnInt = 0
//
//        if pickerView == wendlerPicker {
//            returnInt = wendlerData.count
//        }
//
//        return returnInt
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//
//        var returnStr = ""
//
//        if pickerView == wendlerPicker {
//            returnStr = wendlerData[row]
//        }
//
//        return returnStr
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if pickerView == wendlerPicker {
//            selectedWendler = wendlerData[row]
//            wendlerYesNoTxtField?.text = selectedWendler
//        }
//    }
//}
