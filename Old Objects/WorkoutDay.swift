//
//  CurrentDayWorkout.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 10/3/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

//import Foundation
//
//
//class WorkoutDay: NSObject {
//    
//    var mainExerciseList: ExerciseList?
//    var accExerciseList: ExerciseList?
//
//    var mainExerciseList: [Exercise] = []
//    var accExerciseList: [Exercise] = []
//
//    var title: String?
//
//
//    func addAccExercise(_ obj: Exercise) {
//        accExerciseList.append(obj)
//    }
//    func addMainExercise(_ obj: Exercise) {
//        mainExerciseList.append(obj)
//    }
//
//    func addBlankAccExerciseObj() {
//        let item = Exercise()
//        accExerciseList.append(item)
//    }
//    func addBlankMainExerciseObj() {
//        let item = Exercise()
//        mainExerciseList.append(item)
//    }
//
//
//    func moveAcc(item: Exercise, to index: Int) {
//        guard let currentIndex = accExerciseList.firstIndex(of: item) else {
//            return
//        }
//        accExerciseList.remove(at: currentIndex)
//        accExerciseList.insert(item, at: index)
//    }
//
//    func moveMain(item: Exercise, to index: Int) {
//        guard let currentIndex = mainExerciseList.firstIndex(of: item) else {
//            return
//        }
//        mainExerciseList.remove(at: currentIndex)
//        mainExerciseList.insert(item, at: index)
//    }
//
//    func removeAcc(items: [Exercise]) {
//        for item in items {
//            if let index = accExerciseList.firstIndex(of: item) {
//                accExerciseList.remove(at: index)
//            }
//        }
//    }
//
//    func removeMain(items: [Exercise]) {
//        for item in items {
//            if let index = accExerciseList.firstIndex(of: item) {
//                accExerciseList.remove(at: index)
//            }
//        }
//    }
//
//}
