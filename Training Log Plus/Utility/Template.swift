//
//  TemplateItem.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 9/6/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import Foundation


/*
 *  Template item.
 */

class Template: NSObject {
    
    var title = ""
    //var listOfWorkouts: [WorkoutDay] = []
    var workoutList: WorkoutList
    var dateStarted: String = ""
    var currentDayIndex = 0
    var numDaysOfWeek = 0
    var wendlerYesNo = true
    var numOfWeeks = 0
    //var checked = false
    
    
    override init() {
        workoutList = WorkoutList()
    }
    
    
//    func toggleChecked() {
//        checked = !checked
//    }
    
}
