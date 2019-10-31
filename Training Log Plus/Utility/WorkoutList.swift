//
//  WorkoutList.swift
//  Training Log Plus
//
//  Created by Elliott, Josh on 10/1/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import Foundation

class WorkoutList {
    
    var workouts: [WorkoutDay] = []
    
//    init() {
//        for _ in 0...5 {
//            _ = newExercise()
//        }
//    }
    
    
    func addWorkoutObj(_ obj: WorkoutDay) {
        workouts.append(obj)
    }
    
    func addWorkoutObjWithTitle(_ title: String) {
        let item = WorkoutDay()
        item.setTitle(title)
        workouts.append(item)
    }
    
    func addBlankWorkoutObj() {
        let item = WorkoutDay()
        workouts.append(item)
    }
    
//    func newExercise() -> WorkoutDay {
//        let item = WorkoutDay(title: randTitle())
//        workouts.append(item)
//        return item
//    }
    
    func move(item: WorkoutDay, to index: Int) {
        guard let currentIndex = workouts.firstIndex(of: item) else {
            return
        }
        workouts.remove(at: currentIndex)
        workouts.insert(item, at: index)
    }
    
    func remove(items: [WorkoutDay]) {
        for item in items {
            if let index = workouts.firstIndex(of: item) {
                workouts.remove(at: index)
            }
        }
    }
    
    private func randTitle() -> String {
        let titles = ["Exercise 1", "Exercise 2", "Exercise 3", "Exercise 4", "Exercise 5"]
        let ranNum = Int.random(in: 0 ... titles.count-1)
        return titles[ranNum]
    }
    
    
}
