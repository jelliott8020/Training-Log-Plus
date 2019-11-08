//
//  TMCell.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 10/16/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit

class TMCell {
    
    let reps: Double!
    let weight: Double!
    var trainingMax: Double = 0
    //var displayString: NSMutableAttributedString?

    /*
     * Initializer
     */
    init(reps: Double, weight: Double) {
        self.reps = reps
        self.weight = weight
        trainingMax = getTM()
        //displayString = getDisplayString()
    }
    
    
    /*
     * Getter for TM
     *
     * Calculates the Training Max with the reps and weight
     */
    func getTM() -> Double {
        return rounder(weight * reps * 0.0333 + weight, toNearest: 5)
    }
    
    
//    /*
//     * Get Display String
//     *
//     * Gets the formatted display string for the cell
//     */
//    func getDisplayString() -> NSMutableAttributedString {
//
//        let tmString = " TM: " + String(format: "%.0f", trainingMax)
//        let weightStr = "Weight: " + String(format: "%.0f", weight!)
//        let repsStr = "  |  Reps: " + String(format: "%.0f", reps!) + "  | "
//
//        let totalString = weightStr + repsStr + tmString
//
//        let strNumber: NSString = totalString as NSString
//        let range = (strNumber).range(of: tmString)
//        let attribute = NSMutableAttributedString.init(string: strNumber as String)
//        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: range)
//        attribute.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 17.0), range: range)
//
//        return attribute
//    }
    
    
    /*
     * Rounder Function
     *
     * Rounds the given double to the nearest value
     */
    func rounder(_ value: Double, toNearest: Double) -> Double {
        return round(value / toNearest) * toNearest
    }
}

