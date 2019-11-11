//
//  TrainingMax+CoreDataClass.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 11/8/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//
//

import Foundation
import CoreData


public class TrainingMax: NSManagedObject {
    
    func getEstTM() -> Double {
        return Util.rounder(weight * reps * 0.0333 + weight, toNearest: 5)
    }

}
