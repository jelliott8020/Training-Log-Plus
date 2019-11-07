//
//  WorkoutDay+CoreDataProperties.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 11/5/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//
//

import Foundation
import CoreData


extension WorkoutDay {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutDay> {
        return NSFetchRequest<WorkoutDay>(entityName: "WorkoutDay")
    }

    @NSManaged public var name: String?
    @NSManaged public var mainExerciseList: NSOrderedSet?
    @NSManaged public var accExerciseList: NSOrderedSet?

}

// MARK: Generated accessors for mainExerciseList
extension WorkoutDay {

    @objc(insertObject:inMainExerciseListAtIndex:)
    @NSManaged public func insertIntoMainExerciseList(_ value: Exercise, at idx: Int)

    @objc(removeObjectFromMainExerciseListAtIndex:)
    @NSManaged public func removeFromMainExerciseList(at idx: Int)

    @objc(insertMainExerciseList:atIndexes:)
    @NSManaged public func insertIntoMainExerciseList(_ values: [Exercise], at indexes: NSIndexSet)

    @objc(removeMainExerciseListAtIndexes:)
    @NSManaged public func removeFromMainExerciseList(at indexes: NSIndexSet)

    @objc(replaceObjectInMainExerciseListAtIndex:withObject:)
    @NSManaged public func replaceMainExerciseList(at idx: Int, with value: Exercise)

    @objc(replaceMainExerciseListAtIndexes:withMainExerciseList:)
    @NSManaged public func replaceMainExerciseList(at indexes: NSIndexSet, with values: [Exercise])

    @objc(addMainExerciseListObject:)
    @NSManaged public func addToMainExerciseList(_ value: Exercise)

    @objc(removeMainExerciseListObject:)
    @NSManaged public func removeFromMainExerciseList(_ value: Exercise)

    @objc(addMainExerciseList:)
    @NSManaged public func addToMainExerciseList(_ values: NSOrderedSet)

    @objc(removeMainExerciseList:)
    @NSManaged public func removeFromMainExerciseList(_ values: NSOrderedSet)

}

// MARK: Generated accessors for accExerciseList
extension WorkoutDay {

    @objc(insertObject:inAccExerciseListAtIndex:)
    @NSManaged public func insertIntoAccExerciseList(_ value: Exercise, at idx: Int)

    @objc(removeObjectFromAccExerciseListAtIndex:)
    @NSManaged public func removeFromAccExerciseList(at idx: Int)

    @objc(insertAccExerciseList:atIndexes:)
    @NSManaged public func insertIntoAccExerciseList(_ values: [Exercise], at indexes: NSIndexSet)

    @objc(removeAccExerciseListAtIndexes:)
    @NSManaged public func removeFromAccExerciseList(at indexes: NSIndexSet)

    @objc(replaceObjectInAccExerciseListAtIndex:withObject:)
    @NSManaged public func replaceAccExerciseList(at idx: Int, with value: Exercise)

    @objc(replaceAccExerciseListAtIndexes:withAccExerciseList:)
    @NSManaged public func replaceAccExerciseList(at indexes: NSIndexSet, with values: [Exercise])

    @objc(addAccExerciseListObject:)
    @NSManaged public func addToAccExerciseList(_ value: Exercise)

    @objc(removeAccExerciseListObject:)
    @NSManaged public func removeFromAccExerciseList(_ value: Exercise)

    @objc(addAccExerciseList:)
    @NSManaged public func addToAccExerciseList(_ values: NSOrderedSet)

    @objc(removeAccExerciseList:)
    @NSManaged public func removeFromAccExerciseList(_ values: NSOrderedSet)

}
