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
    var displayString: String = ""

    
    init(reps: Double, weight: Double) {
        self.reps = reps
        self.weight = weight
        trainingMax = getTM()
        displayString = getDisplayString()
    }
    
    func getTM() -> Double {
        return rounder(weight * reps * 0.0333 + weight, toNearest: 5)
    }
    
    func getDisplayString() -> String {
        
        // Test
        
//        let totalString = "Weight: " + weight! + " Reps: " + reps! + " TM: "
//        //let roundedFormatted = String(format: "%.0f", roundedWeight)
//
//        let firstAttributes: [NSAttributedString.Key: Any] = [.backgroundColor: UIColor.green, NSAttributedString.Key.kern: 10]
//        let secondAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
//
//        let firstString = NSMutableAttributedString(string: totalString, attributes: firstAttributes)
//        let secondString = NSAttributedString(string: roundedFormatted, attributes: secondAttributes)
//        //let thirdString = NSAttributedString(string: "hate")
//
//        firstString.append(secondString)
//
//        // End Test
        
        
        // Test
        
        
        
        let tmString = String(format: "%.0f", trainingMax)
        let weightStr = "Weight: " + String(format: "%.0f", weight!)
        let repsStr = " Reps: " + String(format: "%.0f", reps!)
        
        let firstPart = NSMutableString(string: weightStr + repsStr)
        
        let tmStr = " TM: " + tmString
        
        let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.red ]
        let myAttrString = NSAttributedString(string: tmStr, attributes: myAttribute)
        
        //firstPart.append(myAttrString as String)
        
        return firstPart as String
    }
    
    func rounder(_ value: Double, toNearest: Double) -> Double {
        return round(value / toNearest) * toNearest
    }
}

