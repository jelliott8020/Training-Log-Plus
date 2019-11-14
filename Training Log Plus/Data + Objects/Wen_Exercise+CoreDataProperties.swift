//
//  Wen_Exercise+CoreDataProperties.swift
//  Training Log Plus
//
//  Created by Elliott, Josh on 11/14/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//
//

import Foundation
import CoreData


extension Wen_Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Wen_Exercise> {
        return NSFetchRequest<Wen_Exercise>(entityName: "Wen_Exercise")
    }

    @NSManaged public var currentTM: Double
    @NSManaged public var dayOfWeek: Int32
    @NSManaged public var personalRecords: Set<PersonalRecord>
    @NSManaged public var trainingMaxes: Set<TrainingMax>
    @NSManaged public var progression: Wen_Progression?

}

// MARK: Generated accessors for personalRecords
extension Wen_Exercise {

    @objc(addPersonalRecordsObject:)
    @NSManaged public func addToPersonalRecords(_ value: PersonalRecord)

    @objc(removePersonalRecordsObject:)
    @NSManaged public func removeFromPersonalRecords(_ value: PersonalRecord)

    @objc(addPersonalRecords:)
    @NSManaged public func addToPersonalRecords(_ values: NSSet)

    @objc(removePersonalRecords:)
    @NSManaged public func removeFromPersonalRecords(_ values: NSSet)

}

// MARK: Generated accessors for trainingMaxes
extension Wen_Exercise {

    @objc(addTrainingMaxesObject:)
    @NSManaged public func addToTrainingMaxes(_ value: TrainingMax)

    @objc(removeTrainingMaxesObject:)
    @NSManaged public func removeFromTrainingMaxes(_ value: TrainingMax)

    @objc(addTrainingMaxes:)
    @NSManaged public func addToTrainingMaxes(_ values: NSSet)

    @objc(removeTrainingMaxes:)
    @NSManaged public func removeFromTrainingMaxes(_ values: NSSet)

}
