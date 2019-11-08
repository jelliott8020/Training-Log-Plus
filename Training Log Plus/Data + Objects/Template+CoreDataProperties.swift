//
//  Template+CoreDataProperties.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 11/8/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//
//

import Foundation
import CoreData


extension Template {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Template> {
        return NSFetchRequest<Template>(entityName: "Template")
    }

    @NSManaged public var currentDayIndex: Int32
    @NSManaged public var dateStarted: Date?
    @NSManaged public var name: String?
    @NSManaged public var numDaysPerWeek: Int32
    @NSManaged public var numOfWeeks: Int32
    @NSManaged public var wendlerYesNo: Bool
    @NSManaged public var workoutList: NSOrderedSet?

}

// MARK: Generated accessors for workoutList
extension Template {

    @objc(insertObject:inWorkoutListAtIndex:)
    @NSManaged public func insertIntoWorkoutList(_ value: WorkoutDay, at idx: Int)

    @objc(removeObjectFromWorkoutListAtIndex:)
    @NSManaged public func removeFromWorkoutList(at idx: Int)

    @objc(insertWorkoutList:atIndexes:)
    @NSManaged public func insertIntoWorkoutList(_ values: [WorkoutDay], at indexes: NSIndexSet)

    @objc(removeWorkoutListAtIndexes:)
    @NSManaged public func removeFromWorkoutList(at indexes: NSIndexSet)

    @objc(replaceObjectInWorkoutListAtIndex:withObject:)
    @NSManaged public func replaceWorkoutList(at idx: Int, with value: WorkoutDay)

    @objc(replaceWorkoutListAtIndexes:withWorkoutList:)
    @NSManaged public func replaceWorkoutList(at indexes: NSIndexSet, with values: [WorkoutDay])

    @objc(addWorkoutListObject:)
    @NSManaged public func addToWorkoutList(_ value: WorkoutDay)

    @objc(removeWorkoutListObject:)
    @NSManaged public func removeFromWorkoutList(_ value: WorkoutDay)

    @objc(addWorkoutList:)
    @NSManaged public func addToWorkoutList(_ values: NSOrderedSet)

    @objc(removeWorkoutList:)
    @NSManaged public func removeFromWorkoutList(_ values: NSOrderedSet)

}
