//
//  Template+CoreDataProperties.swift
//  Training Log Plus
//
//  Created by Elliott, Josh on 11/14/19.
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
    @NSManaged public var currentWeekIndex: Int32
    @NSManaged public var currentTemplate: Bool
    @NSManaged public var dateStarted: Date?
    @NSManaged public var name: String
    @NSManaged public var numDaysPerWeek: Int32
    @NSManaged public var numOfWeeks: Int32
    @NSManaged public var wendlerYesNo: Bool
    @NSManaged public var workoutList: Set<WorkoutDay>

}

// MARK: Generated accessors for workoutList
extension Template {

    @objc(addWorkoutListObject:)
    @NSManaged public func addToWorkoutList(_ value: WorkoutDay)

    @objc(removeWorkoutListObject:)
    @NSManaged public func removeFromWorkoutList(_ value: WorkoutDay)

    @objc(addWorkoutList:)
    @NSManaged public func addToWorkoutList(_ values: NSSet)

    @objc(removeWorkoutList:)
    @NSManaged public func removeFromWorkoutList(_ values: NSSet)

}
