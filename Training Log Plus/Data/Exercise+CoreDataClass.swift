//
//  Exercise+CoreDataClass.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 11/4/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//
//

import Foundation
import CoreData


public class Exercise: NSManagedObject {

    
        func addAttempt(_ obj: Attempt) {
            attemptList.append(obj)
        }
    
        func addBlankAttempt() {
            let item = Attempt()
            attemptList.append(item)
        }
    
}
