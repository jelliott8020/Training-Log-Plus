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
    

    var templateList: [Template] = []
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var alertTitle: String?
    var alertDays: Int?
    var alertWen: Bool?
    var alertWeeks: Int?
    
    var selectedWendler: String?
    
    var tempNameTxtField: UITextField?
    var numDaysTxtField: UITextField?
    var wendlerYesNoTxtField: UITextField?
    var numWeeksTxtField: UITextField?
    
    @IBAction func addTemplateButton(_ sender: UIBarButtonItem) {
        addButtonAlert()
    }
    @IBAction func createTestData(_ sender: UIBarButtonItem) {
        createTestData()
    }
    
    
    /*
     * Initializer
     */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    /*
     * View Did Load
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        DataManager.getTemplate(tempData: &templateList)
        tableView.reloadData()
        //wendlerData = Util.getYesOrNoForPickerData()
        //self.wendlerPicker.delegate = self
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
}


/**
 * PASSBACK DELEGATE
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
        appDelegate.saveContext()
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


/**
 * TABLE VIEW
 */
extension TemplateParent_VC {
    
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
}


/**
 * UTILITY FUNCTIONS
 */
extension TemplateParent_VC {
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


/**
 *  TEST DATA
 */
extension TemplateParent_VC {
    
    
    func createTestData() {
        
        // Create Template
        let temp1 = getNewTemplate("Template Title 1")
        
        // Create WorkoutDay
        let wo1 = getWorkout()
        let wo2 = getWorkout()
        let wo3 = getWorkout()
        let wo4 = getWorkout()
          
        // Add Workout to Template
        temp1.addToWorkoutList(wo1)
        temp1.addToWorkoutList(wo2)
        temp1.addToWorkoutList(wo3)
        temp1.addToWorkoutList(wo4)
        
        // Add Template Characterists
        //temp1.numDaysPerWeek = temp1.workoutList?.count
        temp1.numDays = temp1.workoutList?.count ?? 0
        temp1.numOfWeeks = 5
        templateList.append(temp1)
        
        appDelegate.saveContext()
        
        tableView.reloadData()
    }
    
    func getWorkout() -> WorkoutDay {
        let wo1 = WorkoutDay(entity: WorkoutDay.entity(), insertInto: context)
        wo1.name = getRandomWorkoutName()
        
        
        for _ in 0...4 {
            let ex1 = getWendlerTestData()
            wo1.addToAccExerciseList(ex1)
        }
        
        for _ in 0...4 {
            let ex1 = getBBTestData()
            wo1.addToAccExerciseList(ex1)
        }
        
        
        // MAIN EXERCISE
        let mainBB = getBBTestData()
        let mainWen = getWendlerTestData()
        
        // Add Main Exercise to Workout
        wo1.addToMainExerciseList(mainBB)
        wo1.addToMainExerciseList(mainWen)
        
        return wo1
    }
    
    func getBBTestData() -> BB_Exercise {
        let item = BB_Exercise(entity: BB_Exercise.entity(), insertInto: context)
        item.name = getRandomBBEx()
        let progMainBB = getNewProgression("3x10")
        item.progression = progMainBB
        item.bodypart = getRandomBodyPart()
        item.startingWeight = 57
        
        for _ in 0...3 {
            
        }
        
        let mainAtt1 = getNewBBAttempt()
        let mainAtt2 = getNewBBAttempt()
        let mainAtt3 = getNewBBAttempt()
        item.addToAttemptList(mainAtt1)
        item.addToAttemptList(mainAtt2)
        item.addToAttemptList(mainAtt3)
        
        return item
    }
    
    func getWendlerTestData() -> Wen_Exercise {
        let item = Wen_Exercise(entity: Wen_Exercise.entity(), insertInto: context)
        item.name = getRandomWendlerEx()
        let progMainWen = getNewProgression("531")
        item.progression = progMainWen
        item.bodypart = getRandomBodyPart()
        item.currentTM = 235.0
        
        let TM1 = getNewWendlerTM()
        let PR1 = getNewWendlerPR()
        let TM2 = getNewWendlerTM()
        let PR2 = getNewWendlerPR()
        item.addToPersonalRecords(PR1)
        item.addToPersonalRecords(PR2)
        item.addToTrainingMaxes(TM1)
        item.addToTrainingMaxes(TM2)
        
        return item
    }
    
    func getNewWendlerTM() -> TrainingMax {
        let item = TrainingMax(entity: TrainingMax.entity(), insertInto: context)
        item.date = Date.init()
        item.weight = 235.0
        item.reps = 5.0
        //item.trainingMax = 335.0
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
    
    func getNewTemplate(_ name: String) -> Template {
        let item = Template(entity: Template.entity(), insertInto: context)
        item.name = name
        item.currentTemplate = true
        return item
    }
    
    func getNewProgression(_ name: String) -> Progression {
        let item = Progression(entity: Progression.entity(), insertInto: context)
        item.name = name
        return item
    }
    
    func getRandomBodyPart() -> String {
        let arg = Util.getBodyPartData()
        return arg[Int.random(in: 0...arg.count-1)]
    }
    
    func getRandomWendlerEx() -> String {
        let arg = ["531 OHP", "531 Squat", "531 Dead", "531 Bench"]
        return arg[Int.random(in: 0...arg.count-1)]
    }
    
    func getRandomBBEx() -> String {
        let arg = ["Incline DB", "Bench", "Leg Press", "RDL", "Hammer Inc", "Hammer Dec"]
        return arg[Int.random(in: 0...arg.count-1)]
    }
    
    func getRandomWorkoutName() -> String {
        let arg = ["Push", "Pull", "Legs", "Chest/Back", "Shoulders/Arms"]
        return arg[Int.random(in: 0...arg.count-1)]
    }
}
