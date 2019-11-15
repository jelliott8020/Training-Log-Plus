//
//  DataManager.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 11/8/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import CoreData
import UIKit


class DataManager {
    
    private static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    //request.predicate = NSPredicate(format: "name CONTAINS[cd] %@", query)
    
    
    
    /*
     * Exercise - All
     */
    static func getExercises(exData: inout [Exercise]) {
        
        let request = Exercise.fetchRequest() as NSFetchRequest<Exercise>
        
        do {
            exData = try context.fetch(request)
        } catch let error as NSError {
            print("Could no fetch ExerciseData. \(error), \(error.userInfo)")
        }
    }
    
    
    /*
     * Exercise - Bodypart
     */
    static func getExercises(bodypart: String, exData: inout [Exercise]) {
        
        let request = Exercise.fetchRequest() as NSFetchRequest<Exercise>
        
        if bodypart != "" {
            request.predicate = NSPredicate(format: "bodypart == '\(bodypart)'")
        }
        
        do {
            exData = try context.fetch(request)
        } catch let error as NSError {
            print("Could no fetch ExerciseData. \(error), \(error.userInfo)")
        }
    }
    
    
    /*
     * Exercise - Name
     */
    static func getExercises(name: String, exData: inout [Exercise]) {
        
        let request = Exercise.fetchRequest() as NSFetchRequest<Exercise>
        request.predicate = NSPredicate(format: "name == '\(name)'")
        
        do {
            exData = try context.fetch(request)
        } catch let error as NSError {
            print("Could no fetch ExerciseData. \(error), \(error.userInfo)")
        }
    }
    
    
    
    
    /*
     * Wendler Exercises
     */
    static func getWenExercise(exStr: String, exData: inout [Exercise]) {
        
        let request = Wen_Exercise.fetchRequest() as NSFetchRequest<Wen_Exercise>
        
        if exStr != "" {
            request.predicate = NSPredicate(format: "bodypart == '\(exStr)'")
            print("entered conditional")
        }
        
        do {
            exData = try context.fetch(request)
        } catch let error as NSError {
            print("Could no fetch Wen_ExerciseData. \(error), \(error.userInfo)")
        }
    }
    
    
    /*
     * Bodybuilding Exercises
     */
    static func getBBExercise(exStr: String, exData: inout [Exercise]) {
        
        let request = BB_Exercise.fetchRequest() as NSFetchRequest<BB_Exercise>
        
        if exStr != "" {
            request.predicate = NSPredicate(format: "bodypart == '\(exStr)'")
        }

        
        do {
            exData = try context.fetch(request)
        } catch let error as NSError {
            print("Could no fetch BB_ExerciseData. \(error), \(error.userInfo)")
        }
    }
    
    
    /*
     * Progression
     */
    static func getProgression(exData: inout [Wen_Progression]) {
        
        let request = Wen_Progression.fetchRequest() as NSFetchRequest<Wen_Progression>
        
        do {
            exData = try context.fetch(request)
        } catch let error as NSError {
            print("Could no fetch Wen_ProgressionData. \(error), \(error.userInfo)")
        }
    }
    
    /*
     * Progression
     */
    static func getProgression(exData: inout [BB_Progression]) {
        
        let request = BB_Progression.fetchRequest() as NSFetchRequest<BB_Progression>
        
        do {
            exData = try context.fetch(request)
        } catch let error as NSError {
            print("Could no fetch BB_ProgressionData. \(error), \(error.userInfo)")
        }
    }
    
    /*
     * Template
     */
    static func getTemplate(tempData: inout [Template]) {
        
        let request = Template.fetchRequest() as NSFetchRequest<Template>
        
        do {
            tempData = try context.fetch(request)
        } catch let error as NSError {
            print("Could no fetch templateData. \(error), \(error.userInfo)")
        }

    }
    
    
    /*
     * Current Template
     */
    static func getTemplate(current: Bool, temp: inout [Template]) {
        
        let request = Template.fetchRequest() as NSFetchRequest<Template>
        
        if (current) {
            request.predicate = NSPredicate(format: "currentTemplate == %@", NSNumber(value: true))
        } else {
            temp.removeAll()
            return
        }
        
        do {
            temp = try context.fetch(request)
        } catch let error as NSError {
            print("Could no fetch templateData. \(error), \(error.userInfo)")
        }
    }
    
    
    /*
     * Current Template
     */
    static func getTemplate(name: String, temp: inout [Template]) {
        
        let request = Template.fetchRequest() as NSFetchRequest<Template>
        request.predicate = NSPredicate(format: "name == '\(name)'")
        
        do {
            temp = try context.fetch(request)
        } catch let error as NSError {
            print("Could no fetch templateData. \(error), \(error.userInfo)")
        }
    }
    
    
    /*
     * Workouts
     */
    static func getWorkouts(tempName: String, workouts: inout [WorkoutDay]) {
        
        let request = WorkoutDay.fetchRequest() as NSFetchRequest<WorkoutDay>
        request.predicate = NSPredicate(format: "currentTemplate == 'true'")
        
        do {
            workouts = try context.fetch(request)
        } catch let error as NSError {
            print("Could no fetch templateData. \(error), \(error.userInfo)")
        }
    }
    
    
}
