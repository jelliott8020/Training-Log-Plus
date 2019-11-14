//
//  BB_Exercise+CoreDataProperties.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 11/10/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//
//

import Foundation
import CoreData


extension BB_Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BB_Exercise> {
        return NSFetchRequest<BB_Exercise>(entityName: "BB_Exercise")
    }

    @NSManaged public var startingWeight: Double
//    @NSManaged public var attemptList: NSSet?
    
    @NSManaged public var attemptList: Set<Attempt>

}

// MARK: Generated accessors for attemptList
extension BB_Exercise {

    @objc(addAttemptListObject:)
    @NSManaged public func addToAttemptList(_ value: Attempt)

    @objc(removeAttemptListObject:)
    @NSManaged public func removeFromAttemptList(_ value: Attempt)

    @objc(addAttemptList:)
    @NSManaged public func addToAttemptList(_ values: NSSet)

    @objc(removeAttemptList:)
    @NSManaged public func removeFromAttemptList(_ values: NSSet)

}
