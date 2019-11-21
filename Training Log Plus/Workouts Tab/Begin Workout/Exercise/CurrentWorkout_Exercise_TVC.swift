//
//  Exercise_TVC.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 10/19/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit
import CoreData

protocol Pass_ExerciseObject_BackTo_CurrentWorkout_Delegate {
    func currentExercise_DidCancel(_ controller: CurrentWorkout_Exercise_TVC)
    func completeWithMainExercise(_ controller: CurrentWorkout_Exercise_TVC, didFinish item: Exercise)
    func completeWithAccExercise(_ controller: CurrentWorkout_Exercise_TVC, didFinish item: Exercise)
}


class CurrentWorkout_Exercise_TVC: UITableViewController {
    
    weak var passedInExerciseObj: AnyObject?
    var selectedExercise: AnyObject?
    
    var selectedProgression: AnyObject?
    
    var attemptList: [Attempt] = []
    var personalRecordsList: [PersonalRecord] = []
    
    var exerciseSets: [Sets] = []
    
    var isItMain: Bool?
    var delegate: Pass_ExerciseObject_BackTo_CurrentWorkout_Delegate?
    
    
    
    
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        doneButtonAction()
    }
    
    func doneButtonAction() {
        if (isItMain!) {
            delegate?.completeWithMainExercise(self, didFinish: selectedExercise as! Exercise)
        } else {
            delegate?.completeWithAccExercise(self, didFinish: selectedExercise as! Exercise)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (passedInExerciseObj?.isKind(of: Wen_Exercise.self) ?? false) {
            
            print("PassedInObj: \(String(describing: passedInExerciseObj as Any))")
            print("PassedProgression: \(String(describing: (passedInExerciseObj as! Wen_Exercise).progression))")
            
            selectedExercise = passedInExerciseObj as! Wen_Exercise
            print("SelectedExercise: \(String(describing: selectedExercise as Any))")
            
            selectedProgression = (passedInExerciseObj as! Wen_Exercise).progression
            
            let trainingMax = (selectedExercise as! Wen_Exercise).currentTM
            
            self.title = selectedExercise?.name
            personalRecordsList = Array(selectedExercise!.personalRecords ?? [])
            exerciseSets = (selectedExercise as! Wen_Exercise).progression!.getSets(weight: trainingMax)
            //exerciseSets = (selectedProgression as! Wen_Progression).getSets(weight: trainingMax)
//            print("WenExSets: ")
//            print(exerciseSets)
//            print(selectedProgression as Any)
            
        } else if (passedInExerciseObj?.isKind(of: BB_Exercise.self) ?? false) {
            
            print("PassedInObj: \(String(describing: passedInExerciseObj as Any))")
            print("PassedProgression: \(String(describing: (passedInExerciseObj as! BB_Exercise).progression))")
            
            selectedExercise = passedInExerciseObj as! BB_Exercise
            print("SelectedExercise: \(String(describing: selectedExercise as Any))")
            
            selectedProgression = (passedInExerciseObj as! BB_Exercise).progression
            
            let weight = (selectedExercise as! BB_Exercise).startingWeight
            
            self.title = selectedExercise?.name
            attemptList = Array(selectedExercise!.attemptList ?? [])
            exerciseSets = (selectedExercise as! BB_Exercise).progression!.getSets(weight: weight)
            //exerciseSets = (selectedProgression as! BB_Progression).getSets(weight: weight)
            
//            print("BBExSets: ")
//            print(exerciseSets)
//            print(selectedProgression as Any)
        }
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//        weak var passedInExercise: Wen_Exercise?
//        var personalRecords: [PersonalRecord] = []
//        var passedInWeight: Double?
        
        //weak var passedInExercise: BB_Exercise?
        
        
        if segue.identifier == "amrapPerformance" {
            if let amrap_VC = segue.destination as? AmrapPerformance_VC {
                if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                    
                    amrap_VC.passedInExercise = selectedExercise as? Wen_Exercise
                    amrap_VC.passedInWeight = 22.0
                }
            }

        } else if segue.identifier == "bbPerformance" {
            if let bb_VC = segue.destination as? BodyBuildingPerformance_TVC {
                if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                    
                    bb_VC.passedInExercise = selectedExercise as? BB_Exercise
                    
                }
            }
        }
    }

}


/**
 * TABLEVIEW
 */
extension CurrentWorkout_Exercise_TVC {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        // Will want to change this with Wendler. Add Base + FSL + Joker. Option to add jokers.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseSets.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dummyCell = UITableViewCell()
        dummyCell.textLabel!.text = "Dummy cell"
        let set = exerciseSets[indexPath.row]
        let weightForCell = "Weight: \(String(set.weight)) " + " |  Reps: \(String(set.reps))"
        
        if (selectedExercise as? Wen_Exercise) != nil {
            let cell = tableView.dequeueReusableCell(withIdentifier: "amrapCell", for: indexPath) as! ExerciseAMRAP_TableViewCell
            cell.cellLabel.text = weightForCell
            return cell
        } else if (selectedExercise as? BB_Exercise) != nil {
            let cell = tableView.dequeueReusableCell(withIdentifier: "bodybuildingCell", for: indexPath) as! ExerciseBB_TableViewCell
            cell.cellLabel.text = weightForCell
            return cell
        }
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "repsAndDoneCell", for: indexPath)
        print("dummy")
        
        return dummyCell
    }
}
