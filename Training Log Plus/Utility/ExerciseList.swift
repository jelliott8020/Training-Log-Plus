//
//  ExerciseList.swift
//  Training Log Plus
//
//  Created by Elliott, Josh on 10/31/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import Foundation

class ExerciseList {
    
    var exercises: [Exercise]?
    
    func addExercise(_ obj: Exercise) {
        exercises?.append(obj)
    }
    
}
