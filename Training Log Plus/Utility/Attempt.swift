//
//  Attempt.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 9/25/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import Foundation

class Attempt {
    
    var date: Date
    var reps: Int
    var sets: Int
    var weight: Double
    
    init(date: Date, reps: Int, sets: Int, weight: Double) {
        self.date = date
        self.reps = reps
        self.sets = sets
        self.weight = weight
    }
    
    
    
}
