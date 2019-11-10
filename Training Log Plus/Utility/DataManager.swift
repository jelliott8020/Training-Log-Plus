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
     * Exercise
     */
    static func getExercises(bp: String, exData: inout [Exercise]) {
        
        let request = Exercise.fetchRequest() as NSFetchRequest<Exercise>
        
        if bp != "" {
            request.predicate = NSPredicate(format: "bodyPart == '\(bp)'")
        }
        
        do {
            exData = try context.fetch(request)
        } catch let error as NSError {
            print("Could no fetch ExerciseData. \(error), \(error.userInfo)")
        }
    }
    
    
    /*
     * Wendler Exercises
     */
    static func getWenExercise(exStr: String, exData: inout [Wen_Exercise]) {
        
        let request = Wen_Exercise.fetchRequest() as NSFetchRequest<Wen_Exercise>
        
        if exStr != "" {
            request.predicate = NSPredicate(format: "bodyPart == '\(exStr)'")
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
    static func getBBExercise(exStr: String, exData: inout [BB_Exercise]) {
        
        let request = BB_Exercise.fetchRequest() as NSFetchRequest<BB_Exercise>
        
        if exStr != "" {
            request.predicate = NSPredicate(format: "bodyPart == '\(exStr)'")
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
    static func getProgression(exData: inout [Progression]) {
        
        let request = Progression.fetchRequest() as NSFetchRequest<Progression>
        
        do {
            exData = try context.fetch(request)
        } catch let error as NSError {
            print("Could no fetch ProgressionData. \(error), \(error.userInfo)")
        }
    }
    
    
}
