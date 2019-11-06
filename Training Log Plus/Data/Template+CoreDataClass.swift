//
//  Template+CoreDataClass.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 11/5/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//
//

import Foundation
import CoreData


public class Template: NSManagedObject {
    
    var numDays : Int {
        get { return Int(numDaysPerWeek) }
        set { numDaysPerWeek = Int32(newValue) }
     }
    
    var currDay: Int {
        get { return Int(currentDayIndex) }
        set { currentDayIndex = Int32(newValue) }
    }
    
    var numWeeks: Int {
        get { return Int(numOfWeeks) }
        set { numOfWeeks = Int32(newValue) }
    }

}
