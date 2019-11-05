//
//  TemplateList.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 9/8/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit
import CoreData

/**
 *  Class to keep the list of template items
 */
class TemplateList {
    
    var templates: [Template] = []
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    init() {
        
        // Create Template
        let temp1 = getNewTemplate("Template Title 1")
        
        // Create WorkoutDay
        let wo1 = getNewWorkoutDay("Tester1")
        
//        "Chest",
//        "Back",
//        "Shoulders",
//        "Arms",
//        "Legs",
//        "Abs",
//        "Misc"
        
        
        // Create Accessory Exercises
        let ex1 = getNewExercise("Bench")
        ex1.bodyPart = "Chest"
        ex1.progression = "531"
        let ex1Att1 = getNewAttempt("ex1Att1")
        let ex1Att2 = getNewAttempt("ex1Att2")
        let ex1Att3 = getNewAttempt("ex1Att3")
        ex1.addAttempt(ex1Att1)
        ex1.addAttempt(ex1Att2)
        ex1.addAttempt(ex1Att3)
        
        
        let ex2 = getNewExercise("Squatter")
        ex2.bodyPart = "Legs"
        ex2.progression = "Cube"
        let ex2Att1 = getNewAttempt("ex2Att1")
        let ex2Att2 = getNewAttempt("ex2Att2")
        let ex2Att3 = getNewAttempt("ex2Att3")
        ex2.addAttempt(ex2Att1)
        ex2.addAttempt(ex2Att2)
        ex2.addAttempt(ex2Att3)
        
        
        let ex3 = getNewExercise("Dead")
        ex3.bodyPart = "Back"
        ex3.progression = "Starting Strength"
        let ex3Att1 = getNewAttempt("ex3Att1")
        let ex3Att2 = getNewAttempt("ex3Att2")
        let ex3Att3 = getNewAttempt("ex3Att3")
        ex3.addAttempt(ex3Att1)
        ex3.addAttempt(ex3Att2)
        ex3.addAttempt(ex3Att3)
        
        //
        let ex4 = getNewExercise("DB Bench")
        ex4.bodyPart = "Chest"
        ex4.progression = "531"
        let ex4Att1 = getNewAttempt("ex1Att1")
        let ex4Att2 = getNewAttempt("ex1Att2")
        let ex4Att3 = getNewAttempt("ex1Att3")
        ex4.addAttempt(ex4Att1)
        ex4.addAttempt(ex4Att2)
        ex4.addAttempt(ex4Att3)
        
        let ex5 = getNewExercise("Incline Bench")
        ex5.bodyPart = "Chest"
        ex5.progression = "531"
        let ex5Att1 = getNewAttempt("ex1Att1")
        let ex5Att2 = getNewAttempt("ex1Att2")
        let ex5Att3 = getNewAttempt("ex1Att3")
        ex5.addAttempt(ex5Att1)
        ex5.addAttempt(ex5Att2)
        ex5.addAttempt(ex5Att3)
        
        let ex6 = getNewExercise("Pullup")
        ex6.bodyPart = "Back"
        ex6.progression = "531"
        let ex6Att1 = getNewAttempt("ex1Att1")
        let ex6Att2 = getNewAttempt("ex1Att2")
        let ex6Att3 = getNewAttempt("ex1Att3")
        ex6.addAttempt(ex6Att1)
        ex6.addAttempt(ex6Att2)
        ex6.addAttempt(ex6Att3)
        
        let ex7 = getNewExercise("Row")
        ex7.bodyPart = "Back"
        ex7.progression = "531"
        let ex7Att1 = getNewAttempt("ex1Att1")
        let ex7Att2 = getNewAttempt("ex1Att2")
        let ex7Att3 = getNewAttempt("ex1Att3")
        ex7.addAttempt(ex7Att1)
        ex7.addAttempt(ex7Att2)
        ex7.addAttempt(ex7Att3)
        
        let ex8 = getNewExercise("Mil Press")
        ex8.bodyPart = "Shoulders"
        ex8.progression = "531"
        let ex8Att1 = getNewAttempt("ex1Att1")
        let ex8Att2 = getNewAttempt("ex1Att2")
        let ex8Att3 = getNewAttempt("ex1Att3")
        ex8.addAttempt(ex8Att1)
        ex8.addAttempt(ex8Att2)
        ex8.addAttempt(ex8Att3)
        //
        
        
        let mainEx = getNewExercise("Main Ex")
        mainEx.bodyPart = "Misc"
        mainEx.progression = "531 BBB"
        let mainAtt1 = getNewAttempt("MainAttemp1")
        let mainAtt2 = getNewAttempt("MainAttempt2")
        let mainAtt3 = getNewAttempt("MainAttempt3")
        mainEx.addAttempt(mainAtt1)
        mainEx.addAttempt(mainAtt2)
        mainEx.addAttempt(mainAtt3)
        
        
        
        
        // Add Main Exercise to Workout
        wo1.addMainExercise(mainEx)
        
        // Add Accessories to Workout
        wo1.addAccExercise(ex1)
        wo1.addAccExercise(ex2)
        wo1.addAccExercise(ex3)
        wo1.addAccExercise(ex4)
        wo1.addAccExercise(ex5)
        wo1.addAccExercise(ex6)
        wo1.addAccExercise(ex7)
        wo1.addAccExercise(ex8)
        
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
    func getNewAttempt(_ name: String) -> Attempt {
        let item = Attempt(entity: Attempt.entity(), insertInto: context)
        item.titleForTest = name
        item.date = Date()
        item.reps = [1,2,3]
        item.sets = 3
        item.weight = 22.0
        return item
    }
    
    func getNewExercise(_ name: String) -> Exercise {
        let item = Exercise(entity: Exercise.entity(), insertInto: context)
        item.name = name
        return item
    }
    
    func getNewWorkoutDay(_ name: String) -> WorkoutDay {
        let item = WorkoutDay()
        item.title = name
        return item
    }
    
    func getNewTemplate(_ name: String) -> Template {
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
