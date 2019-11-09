//
//  WorkoutDay+CoreDataProperties.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 11/8/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//
//

import Foundation
import CoreData


extension WorkoutDay {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutDay> {
        return NSFetchRequest<WorkoutDay>(entityName: "WorkoutDay")
    }

    @NSManaged public var name: String
    @NSManaged public var accExerciseList: NSSet?
    @NSManaged public var mainExerciseList: NSSet?

}

// MARK: Generated accessors for accExerciseList
extension WorkoutDay {

    @objc(addAccExerciseListObject:)
    @NSManaged public func addToAccExerciseList(_ value: Exercise)

    @objc(removeAccExerciseListObject:)
    @NSManaged public func removeFromAccExerciseList(_ value: Exercise)

    @objc(addAccExerciseList:)
    @NSManaged public func addToAccExerciseList(_ values: NSSet)

    @objc(removeAccExerciseList:)
    @NSManaged public func removeFromAccExerciseList(_ values: NSSet)

}

// MARK: Generated accessors for mainExerciseList
extension WorkoutDay {

    @objc(addMainExerciseListObject:)
    @NSManaged public func addToMainExerciseList(_ value: Exercise)

    @objc(removeMainExerciseListObject:)
    @NSManaged public func removeFromMainExerciseList(_ value: Exercise)

    @objc(addMainExerciseList:)
    @NSManaged public func addToMainExerciseList(_ values: NSSet)

    @objc(removeMainExerciseList:)
    @NSManaged public func removeFromMainExerciseList(_ values: NSSet)

}
