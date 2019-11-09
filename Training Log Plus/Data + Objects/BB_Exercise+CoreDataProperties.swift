//
//  BB_Exercise+CoreDataProperties.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 11/8/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//
//

import Foundation
import CoreData


extension BB_Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BB_Exercise> {
        return NSFetchRequest<BB_Exercise>(entityName: "BB_Exercise")
    }

    @NSManaged public var startingWeight: Int32
    @NSManaged public var attemptList: NSOrderedSet?

}

// MARK: Generated accessors for attemptList
extension BB_Exercise {

    @objc(insertObject:inAttemptListAtIndex:)
    @NSManaged public func insertIntoAttemptList(_ value: Attempt, at idx: Int)

    @objc(removeObjectFromAttemptListAtIndex:)
    @NSManaged public func removeFromAttemptList(at idx: Int)

    @objc(insertAttemptList:atIndexes:)
    @NSManaged public func insertIntoAttemptList(_ values: [Attempt], at indexes: NSIndexSet)

    @objc(removeAttemptListAtIndexes:)
    @NSManaged public func removeFromAttemptList(at indexes: NSIndexSet)

    @objc(replaceObjectInAttemptListAtIndex:withObject:)
    @NSManaged public func replaceAttemptList(at idx: Int, with value: Attempt)

    @objc(replaceAttemptListAtIndexes:withAttemptList:)
    @NSManaged public func replaceAttemptList(at indexes: NSIndexSet, with values: [Attempt])

    @objc(addAttemptListObject:)
    @NSManaged public func addToAttemptList(_ value: Attempt)

    @objc(removeAttemptListObject:)
    @NSManaged public func removeFromAttemptList(_ value: Attempt)

    @objc(addAttemptList:)
    @NSManaged public func addToAttemptList(_ values: NSOrderedSet)

    @objc(removeAttemptList:)
    @NSManaged public func removeFromAttemptList(_ values: NSOrderedSet)

}
