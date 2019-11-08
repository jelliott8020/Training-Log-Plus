//
//  UtilityFunctions.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 10/29/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit
import CoreData

class Util {
    
    private static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    /*
     * Check for Good Input
     *
     * Checks the given strings for good input
     * If bad, turns border red, shakes them
     * If good, returns border to default state
     */
    static func checkForBlankInput(str: String, txtField: UITextField) -> Bool {
            if (str == "") {
                shakeAndRedTextField(txtField)
                return true
            } else {
                returnToDefaultTextField(txtField)
                return false
            }
    }
    
    
    /*
     * Get Display String
     *
     * Gets the formatted display string for the cell
     */
    static func getTMDisplayString(trainingMax: Double, weight: Double, reps: Double) -> NSMutableAttributedString {
        
        let tmString = " TM: " + String(format: "%.0f", trainingMax)
        let weightStr = "Weight: " + String(format: "%.0f", weight)
        let repsStr = "  |  Reps: " + String(format: "%.0f", reps) + "  | "
        
        let totalString = weightStr + repsStr + tmString
        
        let strNumber: NSString = totalString as NSString
        let range = (strNumber).range(of: tmString)
        let attribute = NSMutableAttributedString.init(string: strNumber as String)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: range)
        attribute.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 17.0), range: range)
        
        return attribute
    }
    
    
    /*
     * Refresh Exercise List
     *
     * Takes a bodypart text string and querys the DB for exercises
     * that match
     */
    static func refreshExerciseList(bp: String, exData: inout [Exercise]) {
        
        let request = Exercise.fetchRequest() as NSFetchRequest<Exercise>
        request.predicate = NSPredicate(format: "bodyPart == '\(bp)'")
        
        do {
            exData = try context.fetch(request)
        } catch let error as NSError {
            print("Could no fetch exerciseData. \(error), \(error.userInfo)")
        }
    }

    
    /*
     * Clear Text Field
     */
    static func clearTextField(_ textField: UITextField) {
        textField.text = ""
    }
    
    
    /*
     * Shake And Red Text Field
     *
     * Turns the given text field's border red and shakes it
     */
    static func shakeAndRedTextField(_ textField: UITextField) {
        textField.shake()
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor.red.cgColor
    }
    
    
    /*
     * Return to Default Text Field
     *
     * Changes the text field value back to default
     */
    static func returnToDefaultTextField(_ textField: UITextField) {
//        textField.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
//        textField.layer.borderWidth = 1.0
//        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
    }
    
    
    /*
     * Get BodyPart Data
     *
     * Gets the body part data for the picker
     */
    static func getGenericBodyPartData() -> [String] {
        return [
            "Chest",
            "Back",
            "Shoulders",
            "Arms",
            "Legs",
            "Abs",
            "Misc"]
    }
    
    
    /*
     * Get Progression Scheme Data
     *
     * Gets the progression scheme data for the picker
     */
    static func getGenericProgressionData() -> [String] {
        return [
            "3x5 Rep Goal",
            "3x5 + 2x12 @ 70%",
            "3x8 Rep Goal",
            "3x10 Rep Goal",
            "3x12 Rep Goal",
            "4x5 Rep Goal",
            "4x8 Rep Goal",
            "4x10 Rep Goal",
            "4x12 Rep Goal",
            "5x5 Rep Goal",
            "25 reps over 3 sets",
            "25 reps over 5 sets",
            "12/10/8/6, weight +10%",
            "15/12/10/8, weight +10%",
            "6/8/10/12, weight -10%",
            "8/10/12/15, weight -10%"
        ]
    }
    
    
    /*
     * Get Progression Scheme Data
     *
     * Gets the progression scheme data for the picker
     */
    static func getWendlerProgressionData() -> [String] {
        return [
            "531 Base (3 sets)",
            "531 + 2x10 FSL",
            "531 + 5x5 FSL",
            "531 + BBB",
            "531 Pyramid (5 sets)",
            "531 + 2x5 FSL + 1 Joker",
            "531 + 2x5 FSL + 2 Joker",
            "531 + 2x5 FSL + 3 Joker",
            "531 Pyramid + 1 Joker",
            "531 Pyramid + 2 Joker",
            "531 Pyramid + 3 Joker",
        ]
    }
    
    
    /*
     * Get Exercise Data
     *
     * Gets the exercise data for the picker
     */
    static func getGenericExerciseData() -> [String] {
        // Fill this from database after bodypart picker is selected
        return [
            "Squat",
            "Deadlift",
            "Bench"
        ]
    }
    
    
    /*
     * Get Wendler Data
     *
     * Returns data to fill Wendler Picker
     */
    static func getYesOrNoForPickerData() -> [String] {
        return [
            "Yes",
            "No"
        ]
    }
}

extension UIView {
    
    /*
     * Shake the textfield for wrong input
     */
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}

extension String {
    
    /*
     * Check if string is typeof(Int)
     */
    var isInt: Bool {
        return Int(self) != nil
    }
}
