//
//  DailyWorkoutViewController.swift
//  Training Log Plus
//
//  Created by Elliott, Josh on 10/16/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit
import CoreData


class CurrentWorkout_VC: UITableViewController {
    
    weak var passedInTemplate: Template?
    var passedInDayIndex: Int?
    
    var workoutDays: [WorkoutDay] = []
    var currentDay: WorkoutDay?
    
    var accExerciseList: [Exercise] = []
    var mainExerciseList: [Exercise] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = passedInTemplate?.name
        workoutDays = Array(passedInTemplate?.workoutList ?? [])
        currentDay = workoutDays[passedInDayIndex ?? 0]
        
        accExerciseList = Array(currentDay?.accExerciseList ?? [])
        mainExerciseList = Array(currentDay?.mainExerciseList ?? [])
    }
    
    @IBAction func cancel(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    // Prepare for Segue
    //MainExerSegue
    //AccExerSegue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}


/**
 * TABLEVIEW
 */
extension CurrentWorkout_VC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return mainExerciseList.count
        } else {
            return accExerciseList.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dummyCell = UITableViewCell()
        
        if indexPath.section == 0 {
            let weightForCell = mainExerciseList[indexPath.row].name
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainExerciseCell") as! CurrentWorkout_MainExer_TVCell
            cell.cellLabel.text = weightForCell
        } else if indexPath.section == 1 {
            let weightForCell = accExerciseList[indexPath.row].name
            let cell = tableView.dequeueReusableCell(withIdentifier: "AccExerciseCell") as! CurrentWorkout_AccExer_TVCell
            cell.cellLabel.text = weightForCell
        }
        
        return dummyCell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        
        if section == 0 {
            label.text = "Main Exercise"
            label.textColor = UIColor.white
            label.font = UIFont.boldSystemFont(ofSize: 17.0)
            label.textAlignment = .center
        } else if section == 1 {
            label.text = "Accessory Exercises"
            label.textColor = UIColor.white
            label.font = UIFont.boldSystemFont(ofSize: 17.0)
            label.textAlignment = .center
        }
        
        label.backgroundColor = UIColor(rgb: 0x2980B9)
        return label
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.isEditing {
            return
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
}
