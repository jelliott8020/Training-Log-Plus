//
//  TemplateDayCreation_VC.swift
//  Training Log Plus
//
//  Created by Elliott, Josh on 10/24/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit


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
    var passedInWorkoutObj: WorkoutDay?
    var accExerciseList: [Exercise] = []
    var mainExerciseList: [Exercise] = []
    

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
    
    @IBAction func addMoreButton(_ sender: UIButton) {
        // Popup here to add exercises
    }
    
    
    
    /*
     * View Did Load
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exerciseTable.tableFooterView = UIView(frame: CGRect.zero)
        
        accExerciseList = passedInWorkoutObj!.accExerciseList
        mainExerciseList = passedInWorkoutObj!.mainExerciseList
        //workoutObj?.title = passedTitle
        self.title = passedInWorkoutObj?.title
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
            var check = false
            
            check = Util.checkForBlankInput(str: title, txtField: workoutNameTextField)
            
            if (check) {
                return
            }
            
            self.title = workoutNameTextField.text
            passedInWorkoutObj?.title = workoutNameTextField.text!
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "MainExSegue" {
            if let mainEx_VC = segue.destination as? AddEdit_MainExercise_VC {
                if let cell = sender as? UITableViewCell, let indexPath = exerciseTable.indexPath(for: cell) {
                    
                    let item = mainExerciseList[indexPath.row]
                    mainEx_VC.passedInExerciseObj = item
                    mainEx_VC.delegate = self
                }
                
            }
            
        } else if segue.identifier == "AccExSegue" {
            if let accEx_VC = segue.destination as? AddEdit_AccessoryExercise_VC {
                if let cell = sender as? UITableViewCell, let indexPath = exerciseTable.indexPath(for: cell) {
                    
                    let item = accExerciseList[indexPath.row]
                    accEx_VC.passedInExerciseObj = item
                    accEx_VC.delegate = self
                }
                
            }
        }
    }
}


/*
 * TableView Delegate and Data Source
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
            let weightForCell = mainExerciseList[indexPath.row].title
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainExercise") as! DayMainExercise_TVCell
            cell.mainExerLabel.text = weightForCell
            return cell
        } else if indexPath.section == 1 {
            let weightForCell = accExerciseList[indexPath.row].title
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
        } else if section == 1 {
            label.text = "Accessory Exercises"
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
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            accExerciseList.remove(at: indexPath.row)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    

}


/*
 * Delegate
 *
 * Implements the functions that allow the New or Edited Template to be passed back
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
     */
    func addEditMainExercise_PassTo_workoutDayObjectCreation(_ controller: AddEdit_MainExercise_VC, didFinishAdding item: Exercise) {
        //navigationController?.popViewController(animated: true)
        mainExerciseList.append(item)
        let rowIndex = mainExerciseList.count - 1
        let indexPath = IndexPath(row: rowIndex, section: 0)
        exerciseTable.insertRows(at: [indexPath], with: .automatic)
    }
    
    
    /*
     * After editing, data is passed back
     */
    func addEditMainExercise_PassTo_workoutDayObjectCreation(_ controller: AddEdit_MainExercise_VC, didFinishEditing item: Exercise) {
        if let index = mainExerciseList.firstIndex(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = exerciseTable.cellForRow(at: indexPath) {
                cell.textLabel?.text = item.title
            }
        }
        //navigationController?.popViewController(animated: true)
    }
}

/*
 * Delegate
 *
 * Implements the functions that allow the New or Edited Template to be passed back
 */
extension WorkoutDayCreation_VC: Pass_AccessoryExerciseObject_BackTo_WorkoutDayCreation_Delegate {
    
    /*
     * Cancel button will pop the view controller
     */
    func addEditAccExercise_DidCancel(_ controller: AddEdit_AccessoryExercise_VC) {
        navigationController?.popViewController(animated: true)
    }
    
    
    /*
     * After adding, data is passed back
     */
    func addEditAccExercise_PassTo_workoutDayObjectCreation(_ controller: AddEdit_AccessoryExercise_VC, didFinishAdding item: Exercise) {
        //navigationController?.popViewController(animated: true)
        accExerciseList.append(item)
        let rowIndex = accExerciseList.count - 1
        let indexPath = IndexPath(row: rowIndex, section: 1)
        exerciseTable.insertRows(at: [indexPath], with: .automatic)
    }
    
    
    /*
     * After editing, data is passed back
     */
    func addEditAccExercise_PassTo_workoutDayObjectCreation(_ controller: AddEdit_AccessoryExercise_VC, didFinishEditing item: Exercise) {
        if let index = accExerciseList.firstIndex(of: item) {
            let indexPath = IndexPath(row: index, section: 1)
            if let cell = exerciseTable.cellForRow(at: indexPath) {
                cell.textLabel?.text = item.title
            }
        }
        //navigationController?.popViewController(animated: true)
    }
}

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
