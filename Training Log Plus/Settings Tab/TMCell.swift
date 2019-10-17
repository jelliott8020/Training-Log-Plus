//
//  TMCell.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 10/16/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import Foundation

class TMCell {
    let reps: Double!
    let weight: Double!
    let tm: Double!
    let displayString: String!
    
    init(reps: Double, weight: Double) {
        self.reps = reps
        self.weight = weight
        self.tm = rounder(self.weight * self.reps * 0.0333 + self.weight, toNearest: 5)
        self.displayString = "Weight: " + self.weight + " Reps: " + self.reps + " TM: " + String(format: "%.0f", tm)
    }
    
    func rounder(_ value: Double, toNearest: Double) -> Double {
        return round(value / toNearest) * toNearest
    }
}

