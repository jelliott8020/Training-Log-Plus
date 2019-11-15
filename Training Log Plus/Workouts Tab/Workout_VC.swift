//
//  ParentWorkoutViewController.swift
//  Training Log Plus
//
//  Created by Elliott, Josh on 10/16/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit
import CoreData

class Workout_VC: UIViewController {

    var templates: [Template] = []
    var currentTemplate: Template?
    
    var workouts: [WorkoutDay] = []
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var templateLabel: UILabel!
    @IBOutlet weak var tempDayLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataManager.getTemplate(current: true, temp: &templates)
        
        if templates.count == 0 {
            print("Current Templates Empty")
        } else if templates.count == 1 {
            currentTemplate = templates[0]
            workouts = Array(currentTemplate!.workoutList)
        } else {
            print("Multiple Current Templates Returned")
        }
        
        //workouts = currentTemplate[0].workoutList?.allObjects as! [WorkoutDay]
        
        
        refreshDisplay()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DataManager.getTemplate(current: true, temp: &templates)
        
        if templates.count == 0 {
            print("Current Templates Empty")
        } else if templates.count == 1 {
            currentTemplate = templates[0]
            workouts = Array(currentTemplate!.workoutList)
        } else {
            print("Multiple Current Templates Returned")
        }
        
        //workouts = currentTemplate[0].workoutList?.allObjects as! [WorkoutDay]
        
        
        refreshDisplay()
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeTemplateSegue" {
            if let vc = segue.destination as? ChangeTemplate_VC {
                vc.delegate = self
            }
        } else if segue.identifier == "BeginWorkoutSegue" {
            if let vc = segue.destination as? CurrentWorkout_VC {
                vc.delegate = self
                vc.passedInTemplate = currentTemplate
                
            }
        }
    }
}


/**
 * PASSBACK DELEGATE PERFORM WORKOUT
 */
extension Workout_VC: Pass_CurrentWorkout_BackTo_WorkoutParent {
    func currentWorkout_DidCancel(_ controller: CurrentWorkout_VC) {
        navigationController?.popViewController(animated: true)
    }
    
    func workoutComplete(_ controller: CurrentWorkout_VC, didFinish item: WorkoutDay) {
        navigationController?.popViewController(animated: true)
        
        let curr = currentTemplate?.currDay
        
        if curr == currentTemplate!.numDays - 1 {
            currentTemplate?.currDay = 0
            
            let currWeek = currentTemplate?.currWeek
            
            if currWeek == currentTemplate!.numWeeks - 1 {
                print("Finished cycle")
                currentTemplate?.currWeek = 0
            } else {
                currentTemplate?.currWeek += 1
            }
            
        } else {
            currentTemplate?.currDay += 1
        }
        
        refreshDisplay()
        appDelegate.saveContext()
    }
    
    
}

/**
 * PASSBACK DELEGATE TEMPLATE EDIT
 */
extension Workout_VC: Pass_SelectedTemplate_BackTo_Workout_Delegate {
    
    func passTemplateBack(_ controller: ChangeTemplate_VC, didSelect item: Template) {
        
        navigationController?.popViewController(animated: true)
        
        DataManager.getTemplate(current: true, temp: &templates)
        
        for temps in templates {
            temps.currentTemplate = false
        }
        
        print("template returned")
        
        
        templates.removeAll()
        templates.append(item)
        currentTemplate = item
        currentTemplate?.currentTemplate = true
        //workouts = currentTemplate[0].workoutList?.allObjects as! [WorkoutDay]
        workouts = Array(currentTemplate!.workoutList)
        refreshDisplay()
        appDelegate.saveContext()
    }
}


/**
 * UTILITY FUNCTIONS
 */
extension Workout_VC {
    func refreshDisplay() {
        displayDate()
        displayTemplate()
        displayCurrentDay()
    }
    
    func displayDate() {
        let dateFormatter = DateFormatter()
        //dateFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .medium
        let dateString = dateFormatter.string(from: Date() as Date)
        
        dateLabel.text = String(dateString)
    }
    
    func displayTemplate() {
        if currentTemplate != nil {
            templateLabel.text = currentTemplate?.name
        } else {
            templateLabel.text = "No current template selected"
        }
    }
    
    func displayCurrentDay() {
        if currentTemplate != nil {
            tempDayLabel.text = workouts[currentTemplate!.currDay].name
        } else {
            tempDayLabel.text = "No current workout"
        }
    }
}
