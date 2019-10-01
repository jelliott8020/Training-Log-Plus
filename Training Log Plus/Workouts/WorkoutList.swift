//
//  WorkoutList.swift
//  Training Log Plus
//
//  Created by Elliott, Josh on 10/1/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import Foundation

class WorkoutList {
    
    var exercises: [WorkoutListItemObject] = []
    
    init() {
        for _ in 0...5 {
            _ = newExercise()
        }
    }
    
    func addExercise(temp: String) {
        let item = WorkoutListItemObject()
        item.text = temp
        exercises.append(item)
    }
    
    func newExercise() -> WorkoutListItemObject {
        let item = WorkoutListItemObject()
        item.text = randTitle()
        exercises.append(item)
        return item
    }
    
    func move(item: WorkoutListItemObject, to index: Int) {
        guard let currentIndex = exercises.firstIndex(of: item) else {
            return
        }
        exercises.remove(at: currentIndex)
        exercises.insert(item, at: index)
    }
    
    func remove(items: [WorkoutListItemObject]) {
        for item in items {
            if let index = exercises.firstIndex(of: item) {
                exercises.remove(at: index)
            }
        }
    }
    
    private func randTitle() -> String {
        let titles = ["1", "2", "3", "4", "5"]
        let ranNum = Int.random(in: 0 ... titles.count-1)
        return titles[ranNum]
    }
    
    
}
