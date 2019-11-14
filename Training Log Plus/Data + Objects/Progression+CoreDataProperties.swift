//
//  Progression+CoreDataProperties.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 11/10/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//
//

import Foundation
import CoreData


extension Progression {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Progression> {
        return NSFetchRequest<Progression>(entityName: "Progression")
    }

    @NSManaged public var name: String
//    @NSManaged public var sets: NSSet?
    @NSManaged public var sets: Set<Sets>

}

// MARK: Generated accessors for sets
extension Progression {

    @objc(addSetsObject:)
    @NSManaged public func addToSets(_ value: Sets)

    @objc(removeSetsObject:)
    @NSManaged public func removeFromSets(_ value: Sets)

    @objc(addSets:)
    @NSManaged public func addToSets(_ values: NSSet)

    @objc(removeSets:)
    @NSManaged public func removeFromSets(_ values: NSSet)

}
