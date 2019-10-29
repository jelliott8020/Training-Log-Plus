//
//  WorkoutList.swift
//  Training Log Plus
//
//  Created by Elliott, Josh on 10/1/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import Foundation

class WorkoutList {
    
    var exercises: [WorkoutDay] = []
    
    init() {
        for _ in 0...5 {
            _ = newExercise()
        }
    }
    
    func addExercise(temp: String) {
        let item = WorkoutDay(title: temp)
        exercises.append(item)
    }
    
    func newExercise() -> WorkoutDay {
        let item = WorkoutDay(title: randTitle())
        exercises.append(item)
        return item
    }
    
    func move(item: WorkoutDay, to index: Int) {
        guard let currentIndex = exercises.firstIndex(of: item) else {
            return
        }
        exercises.remove(at: currentIndex)
        exercises.insert(item, at: index)
    }
    
    func remove(items: [WorkoutDay]) {
        for item in items {
            if let index = exercises.firstIndex(of: item) {
                exercises.remove(at: index)
            }
        }
    }
    
    private func randTitle() -> String {
        let titles = ["Exercise 1", "Exercise 2", "Exercise 3", "Exercise 4", "Exercise 5"]
        let ranNum = Int.random(in: 0 ... titles.count-1)
        return titles[ranNum]
    }
    
    
}
