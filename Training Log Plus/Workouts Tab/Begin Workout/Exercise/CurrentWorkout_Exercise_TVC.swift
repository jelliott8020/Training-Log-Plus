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
    
    var attemptList: [Attempt] = []
    var personalRecordsList: [PersonalRecord] = []
    
    var exerciseSets: [Sets] = []
    
    var isItMain: Bool?
    var delegate: Pass_ExerciseObject_BackTo_CurrentWorkout_Delegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (passedInExerciseObj?.isKind(of: Wen_Exercise.self) ?? false) {
            
            selectedExercise = passedInExerciseObj as! Wen_Exercise
            
            self.title = selectedExercise?.name
            personalRecordsList = Array(selectedExercise?.personalRecords ?? [])
            //exerciseSets = Array(selectedExercise?.progression??.getSets())
            
        } else if (passedInExerciseObj?.isKind(of: BB_Exercise.self) ?? false) {
            
            selectedExercise = passedInExerciseObj as! BB_Exercise
            
            self.title = selectedExercise?.name
            attemptList = Array(selectedExercise?.attemptList ?? [])
        }
        

    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//        if segue.identifier == "amrapPerformance" {
//            if let amrap_VC = segue.destination as? AmrapPerformance_VC {
//                if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
//                    //let item =
//                }
//            }
//
//        } else if segue.identifier == "bbPerformance" {
//
//        }
    }

}


/**
 * TABLEVIEW
 */
extension CurrentWorkout_Exercise_TVC {
    override func numberOfSections(in tableView: UITableView) -> Int {

        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        return cell
    }
}
