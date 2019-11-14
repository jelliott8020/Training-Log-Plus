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

    var currentTemplate: [Template] = []
    var workouts: [WorkoutDay] = []
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var templateLabel: UILabel!
    @IBOutlet weak var tempDayLabel: UILabel!

    
//    @IBAction func beginWorkoutButton(_ sender: UIButton) {
//        print("being")
//    }
//    
//    @IBAction func changeTemplateButton(_ sender: UIButton) {
//        print("change")
//    }
//    
//    @IBAction func skipDayButton(_ sender: UIButton) {
//        print("skip")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataManager.getTemplate(current: true, temp: &currentTemplate)
        
        if !currentTemplate.isEmpty {
            //workouts = currentTemplate[0].workoutList?.allObjects as! [WorkoutDay]
            workouts = Array(currentTemplate[0].workoutList)
        }
        
        displayDate()
        displayTemplate()
        displayCurrentDay()

        // Do any additional setup after loading the view.
    }
    
    func displayDate() {
        let dateFormatter = DateFormatter()
        //dateFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .medium
        
        let dateString = dateFormatter.string(from: Date() as Date)
        
        dateLabel.text = String(dateString)
    }
    
    func displayTemplate() {
        if !currentTemplate.isEmpty {
            templateLabel.text = currentTemplate[0].name
        } else {
            templateLabel.text = "No current template selected"
        }
    }
    
    func displayCurrentDay() {
        if !currentTemplate.isEmpty {
            tempDayLabel.text = workouts[currentTemplate[0].currDay].name
        } else {
            tempDayLabel.text = "No current workout"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeTemplateSegue" {
            if let vc = segue.destination as? ChangeTemplate_VC {
                vc.delegate = self
            }
        }
    }
}

extension Workout_VC: Pass_SelectedTemplate_BackTo_Workout_Delegate {
    
    func passTemplateBack(_ controller: ChangeTemplate_VC, didSelect item: Template) {
        
        navigationController?.popViewController(animated: true)
        
        for temps in currentTemplate {
            temps.currentTemplate = false
        }
        
        currentTemplate.removeAll()
        currentTemplate.append(item)
        currentTemplate[0].currentTemplate = true
        //workouts = currentTemplate[0].workoutList?.allObjects as! [WorkoutDay]
        workouts = Array(currentTemplate[0].workoutList)
        displayTemplate()
        displayCurrentDay()
        appDelegate.saveContext()
    }
}
