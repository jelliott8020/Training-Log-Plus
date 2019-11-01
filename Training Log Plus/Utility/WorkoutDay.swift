//
//  CurrentDayWorkout.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 10/3/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import Foundation


class WorkoutDay: NSObject {
    
    var mainExercise: Exercise?
    var accExercises: [Exercise] = []
    
    var title: String?

    func setTitle(_ title: String) {
        self.title = title
    }
    
    func getExercises() -> [Exercise] {
        return accExercises
    }
    
    func getMainExercise() -> Exercise {
        return mainExercise!
    }
    
    func addAccExercise(ex: Exercise) {
        accExercises.append(ex)
    }
    
    func addMainExercise(ex: Exercise) {
        mainExercise = ex
    }
    
}
