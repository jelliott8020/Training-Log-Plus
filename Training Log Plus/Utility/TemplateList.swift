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
        
        // Create Template
        let temp1 = newTemplate("Template Title 1")
        
        // Create WorkoutDay
        let wo1 = newWorkoutDay("Tester1")
        
        
        // Create Accessory Exercises
        let ex1 = newExercise("Bench")
        ex1.bodyPart = "Push"
        ex1.progression = "531"
        let ex2 = newExercise("Squatter")
        ex2.bodyPart = "Legs"
        ex2.progression = "Cube"
        let ex3 = newExercise("Dead")
        ex3.bodyPart = "Pull"
        ex3.progression = "Starting Strength"
        
        
        // Create Main Exercise
        let mainEx = newExercise("Main Ex")
        mainEx.bodyPart = "Main Bodypart"
        mainEx.progression = "531 BBB"
        
        
        // Add attempts to Main Exercise
        let mainAtt1 = newAttempt("MainAttemp1")
        let mainAtt2 = newAttempt("MainAttempt2")
        let mainAtt3 = newAttempt("MainAttempt3")
        mainEx.addAttempt(mainAtt1)
        mainEx.addAttempt(mainAtt2)
        mainEx.addAttempt(mainAtt3)
        
        
        // Add attempts to Acc Exercises
        let ex1Att1 = newAttempt("ex1Att1")
        let ex1Att2 = newAttempt("ex1Att2")
        let ex1Att3 = newAttempt("ex1Att3")
        ex1.addAttempt(ex1Att1)
        ex1.addAttempt(ex1Att2)
        ex1.addAttempt(ex1Att3)
        
        let ex2Att1 = newAttempt("ex2Att1")
        let ex2Att2 = newAttempt("ex2Att2")
        let ex2Att3 = newAttempt("ex2Att3")
        ex2.addAttempt(ex2Att1)
        ex2.addAttempt(ex2Att2)
        ex2.addAttempt(ex2Att3)
        
        let ex3Att1 = newAttempt("ex3Att1")
        let ex3Att2 = newAttempt("ex3Att2")
        let ex3Att3 = newAttempt("ex3Att3")
        ex3.addAttempt(ex3Att1)
        ex3.addAttempt(ex3Att2)
        ex3.addAttempt(ex3Att3)
        
        
        // Add Main Exercise to Workout
        wo1.addMainExercise(mainEx)
        
        // Add Accessories to Workout
        wo1.addAccExercise(ex1)
        wo1.addAccExercise(ex2)
        wo1.addAccExercise(ex3)
        
        // Add Workout to Template
        temp1.addWorkout(wo1)
        
        // Add Template Characterists
        temp1.numDaysOfWeek = temp1.workoutList.count
        temp1.numOfWeeks = 1
        templates.append(temp1)
    }
    
    /********************/
    // Helper Functions //
    /********************/
    func newAttempt(_ name: String) -> Attempt {
        let item = Attempt()
        item.titleForTest = name
        return item
    }
    
    func newExercise(_ name: String) -> Exercise {
        let item = Exercise()
        item.name = name
        return item
    }
    
    func newWorkoutDay(_ name: String) -> WorkoutDay {
        let item = WorkoutDay()
        item.title = name
        return item
    }
    
    func newTemplate(_ name: String) -> Template {
        let item = Template()
        item.name = name
        return item
    }
    
    // END HELPER FUCNTIONS //
    
    
    
    
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
        wo1.title = "Tester1"
        let wo2 = WorkoutDay()
        wo2.title = "Tester1"
        let wo3 = WorkoutDay()
        wo3.title = "Tester1"
        let wo4 = WorkoutDay()
        wo4.title = "Tester1"
        workoutArg.append(wo1)
        workoutArg.append(wo2)
        workoutArg.append(wo3)
        workoutArg.append(wo4)
        
        print(workoutArg.count)
        
        return workoutArg
    }
}
