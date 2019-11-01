//
//  AddAccessoryExercise_VC.swift
//  Training Log Plus
//
//  Created by Elliott, Josh on 10/24/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit

protocol Pass_AccessoryExerciseObject_BackTo_WorkoutDayCreation_Delegate {
    //func passWorkoutObjBack(workoutObj: WorkoutDay)
    // User hit cancel
    func addEditAccExercise_DidCancel(_ controller: AddEdit_AccessoryExercise_VC)
    // User added item
    func addEditAccExercise_PassTo_workoutDayObjectCreation(_ controller: AddEdit_AccessoryExercise_VC, didFinishAdding item: Exercise)
    // User finishes editing
    func addEditAccExercise_PassTo_workoutDayObjectCreation(_ controller: AddEdit_AccessoryExercise_VC, didFinishEditing item: Exercise)
}

class AddEdit_AccessoryExercise_VC: UIViewController {

    
    var delegate: Pass_AccessoryExerciseObject_BackTo_WorkoutDayCreation_Delegate?
    var pastAttemptsList: [Attempt] = []
    var passedInExerciseObj: Exercise?
    
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    @IBOutlet weak var bodyPartTextField: UITextField!
    @IBOutlet weak var exerciseTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var setsTextField: UITextField!
    @IBOutlet weak var repsTextField: UITextField!
    
    @IBOutlet weak var pastAttempsTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pastAttempsTable.tableFooterView = UIView(frame: CGRect.zero)
        
        pastAttemptsList = passedInExerciseObj!.attemptList
        self.title = passedInExerciseObj?.title
        
        bodyPartTextField.text = passedInExerciseObj!.bodyPart
        exerciseTextField.text = passedInExerciseObj!.title

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        
        passedInExerciseObj?.bodyPart = bodyPartTextField.text
        passedInExerciseObj?.title = exerciseTextField.text
        
        delegate?.addEditAccExercise_PassTo_workoutDayObjectCreation(self, didFinishEditing: passedInExerciseObj!)
        dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AddEdit_AccessoryExercise_VC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pastAttemptsList.count
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weightForCell = pastAttemptsList[indexPath.row].titleForTest
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "pastAccessoryData") as! AccessoryExercise_TVCell
        
        cell.pastAttemptLabel.text = weightForCell
        
        return cell
    }
    
    
}
