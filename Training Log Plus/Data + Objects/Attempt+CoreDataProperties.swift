//
//  Attempt+CoreDataProperties.swift
//  Training Log Plus
//
//  Created by Elliott, Josh on 11/14/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//
//

import Foundation
import CoreData


extension Attempt {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Attempt> {
        return NSFetchRequest<Attempt>(entityName: "Attempt")
    }

    @NSManaged public var date: Date?
    @NSManaged public var bb_exer: BB_Exercise?
    @NSManaged public var sets: Set<Sets>

}

// MARK: Generated accessors for sets
extension Attempt {

    @objc(addSetsObject:)
    @NSManaged public func addToSets(_ value: Sets)

    @objc(removeSetsObject:)
    @NSManaged public func removeFromSets(_ value: Sets)

    @objc(addSets:)
    @NSManaged public func addToSets(_ values: NSSet)

    @objc(removeSets:)
    @NSManaged public func removeFromSets(_ values: NSSet)

}
