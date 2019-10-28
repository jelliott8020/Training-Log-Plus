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


    }
}
