//
//  PersonalRecord+CoreDataClass.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 11/8/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//
//

import Foundation
import CoreData


public class PersonalRecord: NSManagedObject {
    
    func getEstTM() -> Double {
        return (weight * reps * 0.0333) + weight
    }

}
