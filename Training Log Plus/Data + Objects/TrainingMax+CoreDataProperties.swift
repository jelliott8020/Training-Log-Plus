//
//  TrainingMax+CoreDataProperties.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 11/8/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//
//

import Foundation
import CoreData


extension TrainingMax {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrainingMax> {
        return NSFetchRequest<TrainingMax>(entityName: "TrainingMax")
    }

    @NSManaged public var trainingMax: Double
    @NSManaged public var date: Date?

}
