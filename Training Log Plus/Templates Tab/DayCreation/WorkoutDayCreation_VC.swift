//
//  TemplateDayCreation_VC.swift
//  Training Log Plus
//
//  Created by Elliott, Josh on 10/24/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit

//protocol WorkoutDayCreation_Delegate: class {
//    // User hit cancel
//    func itemDetailViewControllerDidCancel(_ controller: AddEditTemplate_VC)
//    // User added item
//    func itemDetailViewController(_ controller: AddEditTemplate_VC, didFinishAdding item: TemplateItem)
//    // User finishes editing
//    func itemDetailViewController(_ controller: AddEditTemplate_VC, didFinishEditing item: TemplateItem)
//}

protocol WorkoutCreationPassDataBackProtocol {
    func passWorkoutObjBack(workoutObj: WorkoutDay)
}

class WorkoutDayCreation_VC: UIViewController {
    
    var delegate: WorkoutCreationPassDataBackProtocol?

    @IBOutlet weak var workoutNameTextField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var exerciseTable: UITableView!
    
    var workoutObj: WorkoutDay?
    var exerciseArg: [Exercise] = []
    
    
    @IBAction func updateNameButton(_ sender: UIButton) {
        // Update VC Title with text
    }
    
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        
        if let name = workoutNameTextField.text {
            
            workoutObj?.title = name
            
            delegate?.passWorkoutObjBack(workoutObj: workoutObj!)
            
            dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exerciseTable.tableFooterView = UIView(frame: CGRect.zero)
        
        exerciseArg = workoutObj!.getExercises()


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
        
        
        /*
         * ERROR HERE
         */
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainExercise") as! MainExercise_TVCell
        cell.trainingMaxLabel.text = weightForCell
        
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
