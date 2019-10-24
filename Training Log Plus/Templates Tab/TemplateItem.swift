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

class TemplateItem: NSObject {
    
    var templateTitle = ""
    var listOfWorkouts: [Exercise] = []
    var dateStarted: String = ""
    var currentDayIndex = 0
    var numDaysOfWeek = 0
    var wendlerYesNo = true
    var numOfWeeks = 0
    //var checked = false
    
    
    
//    func toggleChecked() {
//        checked = !checked
//    }
    
}
