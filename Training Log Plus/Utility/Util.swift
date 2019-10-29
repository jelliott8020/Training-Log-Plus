//
//  UtilityFunctions.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 10/29/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit

class Util {
    
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
     * Clear Text Field
     */
    static func clearTextField(_ textField: UITextField) {
        textField.text = ""
    }
    
    
    /*
     Shake And Red Text Field
     
     Turns the given text field's border red and shakes it
     */
    static func shakeAndRedTextField(_ textField: UITextField) {
        let redColor = UIColor.red
        textField.shake()
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = redColor.cgColor
    }
    
    
    /*
     Return to Default Text Field
     
     Changes the text field value back to default
     */
    static func returnToDefaultTextField(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 5
    }
    
    /*
     * Get BodyPart Data
     *
     * Gets the body part data for the picker
     */
    static func getGenericBodyPartData() -> [String] {
        return ["Chest", "Back", "Shoulders", "Arms", "Legs", "Abs", "Misc"]
    }
    
    
    /*
     * Get Exercise Data
     *
     * Gets the exercise data for the picker
     */
    static func getGenericExerciseData() -> [String] {
        // Fill this from database after bodypart picker is selected
        return ["Squat", "Deadlift", "Bench"]
    }
    
    
    /*
     * Get Wendler Data
     *
     * Returns data to fill Wendler Picker
     */
    static func getYesOrNoForPickerData() -> [String] {
        return ["Yes", "No"]
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
