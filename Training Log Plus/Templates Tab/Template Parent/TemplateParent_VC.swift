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
    
    /*
     * TEST DATA DRIVER
     */
    func createTestData() {
        
        templateList.removeAll()
        appDelegate.saveContext()
        
        for _ in 0...3 {
            let temp1 = getTemplate()
            templateList.append(temp1)
        }
        
        var count = 0
        while (count < 4) {
            let temp1 = getTemplate()
            
            if temp1 != nil {
                count += 1
                templateList.append(temp1)
            }
        }
        
        appDelegate.saveContext()
        tableView.reloadData()
    }
    
    
    /*
     * GET TEMPLATE
     */
    func getTemplate() -> Template {
        
        let nameString = getRandomTemplateName()
        var tempArg: [Template] = []
        DataManager.getTemplate(name: nameString, temp: &tempArg)
        
        if (tempArg.count == 1) {
            return
        } else if (!tempArg.isEmpty) {
            print("\n\n\nmultiples\n\n\n")
            return
        } else {
            let item = Template(entity: Template.entity(), insertInto: context)
            
            item.name = nameString
            item.numDays = 4
            item.numOfWeeks = 5
            item.currentDayIndex = 0
            item.currentTemplate = false
            
            for _ in 0...3 {
                let wo = getWorkout()
                item.addToWorkoutList(wo)
            }
            
            return item
        }
        
        
        
    }
    
    
    /*
     * GET WORKOUT
     */
    func getWorkout() -> WorkoutDay {
        let wo1 = WorkoutDay(entity: WorkoutDay.entity(), insertInto: context)
        wo1.name = getRandomWorkoutName()
        
        
        for _ in 0...3 {
            let ex1 = getWendlerTestData()
            wo1.addToAccExerciseList(ex1)
        }
        
        for _ in 0...3 {
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
    
    
    /*
     * GET BB_EXERCISE
     */
    func getBBTestData() -> BB_Exercise {
        let item = BB_Exercise(entity: BB_Exercise.entity(), insertInto: context)
        item.name = getRandomBBEx()
        let progMainBB = getNewProgression("3x10")
        item.progression = progMainBB
        item.bodypart = getRandomBodyPart()
        item.startingWeight = 57
        
        for _ in 0...3 {
            let att = getNewBBAttempt()
            item.addToAttemptList(att)
        }
        
        return item
    }
    
    
    /*
     * GET WEN_EXERCISE
     */
    func getWendlerTestData() -> Wen_Exercise {
        let item = Wen_Exercise(entity: Wen_Exercise.entity(), insertInto: context)
        item.name = getRandomWendlerEx()
        let progMainWen = getNewProgression("531")
        item.progression = progMainWen
        item.bodypart = getRandomBodyPart()
        item.currentTM = 235.0
        
        
        for _ in 0...3 {
            let tm = getNewWendlerTM()
            item.addToTrainingMaxes(tm)
        }
        
        for _ in 0...3 {
            let pr = getNewWendlerPR()
            item.addToPersonalRecords(pr)
        }
        
        return item
    }
    
    
    /*
     * GET WENDLER TM
     */
    func getNewWendlerTM() -> TrainingMax {
        let item = TrainingMax(entity: TrainingMax.entity(), insertInto: context)
        item.date = Date.init()
        item.weight = 235.0
        item.reps = 5.0
        return item
    }
    
    
    /*
     * GET WENDLER PR
     */
    func getNewWendlerPR() -> PersonalRecord {
        let item = PersonalRecord(entity: PersonalRecord.entity(), insertInto: context)
        item.date = Date.init()
        item.weight = 225.0
        item.reps = 12.0
        return item
    }
    
    
    /*
     * GET BB ATTEMPT
     */
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
    
    
    /*
     * GET PROGRESSION
     */
    func getNewProgression(_ name: String) -> Progression {
        let item = Progression(entity: Progression.entity(), insertInto: context)
        item.name = name
        return item
    }
    
    
    /*
     * RANDOM GENERATORS
     */
    func getRandomBodyPart() -> String {
        let arg = Util.getBodyPartData()
        return arg[Int.random(in: 0...arg.count-1)]
    }
    
    func getRandomWendlerEx() -> String {
        let arg = ["531 OHP", "531 Squat", "531 Dead", "531 Bench"]
        return arg[Int.random(in: 0...arg.count-1)]
    }
    
    func getRandomBBEx() -> String {
        let arg = ["Incline DB", "Bench", "Leg Press", "RDL"]
        return arg[Int.random(in: 0...arg.count-1)]
    }
    
    func getRandomWorkoutName() -> String {
        let arg = ["Push", "Pull", "Legs", "Chest/Back"]
        return arg[Int.random(in: 0...arg.count-1)]
    }
    
    func getRandomTemplateName() -> String {
        let arg = ["PPL", "Arnold Split", "Bro Split", "Upper Lower"]
        return arg[Int.random(in: 0...arg.count-1)]
    }
}
