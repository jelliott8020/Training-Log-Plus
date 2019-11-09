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
     * Exercise w/ Bodypart
     */
    static func getExercises(bp: String, exData: inout [Exercise]) {
        
        let request = Exercise.fetchRequest() as NSFetchRequest<Exercise>
        request.predicate = NSPredicate(format: "bodyPart == '\(bp)'")
        
        do {
            exData = try context.fetch(request)
        } catch let error as NSError {
            print("Could no fetch ExerciseData. \(error), \(error.userInfo)")
        }
    }
    
    /*
     * Exercise w/o Bodypart
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
     * Wendler Exercises
     */
    static func getWenExercises(exData: inout [Wen_Exercise]) {
        
        let request = Wen_Exercise.fetchRequest() as NSFetchRequest<Wen_Exercise>
        
        do {
            exData = try context.fetch(request)
        } catch let error as NSError {
            print("Could no fetch Wen_ExerciseData. \(error), \(error.userInfo)")
        }
    }
    
    /*
     * Wendler Exercises
     */
    static func getWenExercise(exStr: String, exData: inout [Wen_Exercise]) {
        
        let request = Wen_Exercise.fetchRequest() as NSFetchRequest<Wen_Exercise>
        request.predicate = NSPredicate(format: "name == '\(exStr)'")
        
        do {
            exData = try context.fetch(request)
        } catch let error as NSError {
            print("Could no fetch Wen_ExerciseData. \(error), \(error.userInfo)")
        }
    }
    
    /*
     * Bodybuilding Exercises
     */
    static func getBBExercises(exData: inout [BB_Exercise]) {
        
        let request = BB_Exercise.fetchRequest() as NSFetchRequest<BB_Exercise>
        
        do {
            exData = try context.fetch(request)
        } catch let error as NSError {
            print("Could no fetch BB_ExerciseData. \(error), \(error.userInfo)")
        }
    }
    
    /*
     * Bodybuilding Exercises
     */
    static func getBBExercise(exStr: String, exData: inout [BB_Exercise]) {
        
        let request = BB_Exercise.fetchRequest() as NSFetchRequest<BB_Exercise>
        request.predicate = NSPredicate(format: "name == '\(exStr)'")
        
        do {
            exData = try context.fetch(request)
        } catch let error as NSError {
            print("Could no fetch BB_ExerciseData. \(error), \(error.userInfo)")
        }
    }
}
