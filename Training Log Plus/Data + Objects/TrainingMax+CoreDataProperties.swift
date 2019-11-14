//
//  TrainingMax+CoreDataProperties.swift
//  Training Log Plus
//
//  Created by Elliott, Josh on 11/14/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//
//

import Foundation
import CoreData


extension TrainingMax {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrainingMax> {
        return NSFetchRequest<TrainingMax>(entityName: "TrainingMax")
    }

    @NSManaged public var date: Date?
    @NSManaged public var reps: Double
    @NSManaged public var trainingMax: Double
    @NSManaged public var weight: Double
    @NSManaged public var wen_Exer: Wen_Exercise?

}
