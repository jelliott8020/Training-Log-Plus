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
    var workoutObj: WorkoutDay?
    var exerciseArg: [Exercise] = []

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
        
        exerciseArg = workoutObj!.getExercises()
        self.title = workoutObj?.title
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
        
        delegate?.workoutDayObjectCreation_PassTo_AddEditTemplate(self, didFinishEditing: workoutObj!)
        
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
            workoutObj?.title = workoutNameTextField.text!
        }
    }
}


/*
 * TableView Delegate and Data Source
 */
extension WorkoutDayCreation_VC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseArg.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weightForCell = exerciseArg[indexPath.row].name
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainExercise") as! DayMainExercise_TVCell
        cell.mainExerLabel.text = weightForCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            exerciseArg.remove(at: indexPath.row)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
}
