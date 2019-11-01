//
//  TemplateList.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 9/8/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import Foundation

/**
 *  Class to keep the list of template items
 */
class TemplateList {
    
    var templates: [Template] = []
    
    init() {
        let temp1 = Template()
        temp1.title = "Template Title 1"
        
        let wo1 = WorkoutDay()
        wo1.setTitle("Tester1")
//        let wo2 = WorkoutDay()
//        wo2.setTitle("Tester2")
//        let wo3 = WorkoutDay()
//        wo3.setTitle("Tester3")
//        let wo4 = WorkoutDay()
//        wo4.setTitle("Tester4")
        
        
        let ex1 = Exercise("Bench")
        let ex2 = Exercise("Squatter")
        let ex3 = Exercise("Dead")
        
        let mainEx = Exercise("Main Ex")
        
        let att1 = Attempt()
        att1.titleForTest = "Attemp1"
        let att2 = Attempt()
        att2.titleForTest = "Attempt2"
        let att3 = Attempt()
        att3.titleForTest = "Attempt3"
        
        mainEx.attemptList?.addAttemptObj(att1)
        mainEx.attemptList?.addAttemptObj(att2)
        mainEx.attemptList?.addAttemptObj(att3)
        
        wo1.addMainExercise(ex: mainEx)
        
        wo1.addAccExercise(ex: ex1)
        wo1.addAccExercise(ex: ex2)
        wo1.addAccExercise(ex: ex3)
        
        temp1.workoutList.addWorkoutObj(wo1)
        //temp1.workoutList.addWorkoutObj(wo2)
        //temp1.workoutList.addWorkoutObj(wo3)
        //temp1.workoutList.addWorkoutObj(wo4)
        
        temp1.numDaysOfWeek = temp1.workoutList.workouts.count
        temp1.numOfWeeks = 1
        templates.append(temp1)
    }
    
    
    /*
     Add Template: Adds a template object to array
     */
    func addTemplate(_ temp: Template) {
        templates.append(temp);
    }
    
    
    /*
     New Template: Adds a new blank template object to array
     */
    func newTemplate() -> Template {
        let item = Template()
        templates.append(item)
        return item
    }
    
    
    /*
     Move Template: Moves template to a different index in array
     */
    func move(item: Template, to index: Int) {
        guard let currentIndex = templates.firstIndex(of: item) else {
            return
        }
        templates.remove(at: currentIndex)
        templates.insert(item, at: index)
    }
    
    
    /*
     Remove Template: Removes a template from the array
     */
    func remove(items: [Template]) {
        for item in items {
            if let index = templates.firstIndex(of: item) {
                templates.remove(at: index)
            }
        }
    }
    
    
    /*
     Add Workouts: Create WorkoutDay array, add random stuff, return
     */
    func addWorkouts() -> [WorkoutDay] {
        print("hi")
        var workoutArg: [WorkoutDay] = []
        let wo1 = WorkoutDay()
        wo1.setTitle("Tester1")
        let wo2 = WorkoutDay()
        wo2.setTitle("Tester2")
        let wo3 = WorkoutDay()
        wo3.setTitle("Tester3")
        let wo4 = WorkoutDay()
        wo4.setTitle("Tester4")
        workoutArg.append(wo1)
        workoutArg.append(wo2)
        workoutArg.append(wo3)
        workoutArg.append(wo4)
        
        print(workoutArg.count)
        
        return workoutArg
    }
    
    
    /*
     Random Title: Creates and returns a random WorkoutDay title
     */
    private func randTitle() -> String {
        let titles = ["Workout Day 1", "Workout Day 2", "Workout Day 3", "Workout Day 4"]
        let ranNum = Int.random(in: 0 ... titles.count-1)
        return titles[ranNum]
    }
}
