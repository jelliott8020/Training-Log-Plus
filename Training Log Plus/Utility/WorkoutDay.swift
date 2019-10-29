//
//  CurrentDayWorkout.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 10/3/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import Foundation


class WorkoutDay: NSObject {
    
    var exercises: [Exercise] = []
    
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
    func getExercises() -> [Exercise] {
        return exercises
    }
    
    func addExercise(ex: Exercise) {
        exercises.append(ex)
    }
    
}
