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
    var tm: Double = 0
    var displayString: String = ""

    
    init(reps: Double, weight: Double) {
        self.reps = reps
        self.weight = weight
        tm = getTM()
        displayString = getDisplayString()
    }
    
    func getTM() -> Double {
        return rounder(weight * reps * 0.0333 + weight, toNearest: 5)
    }
    
    func getDisplayString() -> String {
        let tmString = String(format: "%.0f", tm)
        let weightStr = "Weight: " + String(format: "%.0f", weight!)
        let repsStr = " Reps: " + String(format: "%.0f", reps!)
        let tmStr = " TM: " + tmString
        return weightStr + repsStr + tmStr
    }
    
    func rounder(_ value: Double, toNearest: Double) -> Double {
        return round(value / toNearest) * toNearest
    }
}

