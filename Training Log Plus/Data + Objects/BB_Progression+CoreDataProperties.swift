//
//  BB_Progression+CoreDataProperties.swift
//  Training Log Plus
//
//  Created by Elliott, Josh on 11/14/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//
//

import Foundation
import CoreData


extension BB_Progression {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BB_Progression> {
        return NSFetchRequest<BB_Progression>(entityName: "BB_Progression")
    }

    @NSManaged public var name: String
    @NSManaged public var sets: Set<Sets>
    @NSManaged public var exercise: BB_Exercise?

}

// MARK: Generated accessors for sets
extension BB_Progression {

    @objc(addSetsObject:)
    @NSManaged public func addToSets(_ value: Sets)

    @objc(removeSetsObject:)
    @NSManaged public func removeFromSets(_ value: Sets)

    @objc(addSets:)
    @NSManaged public func addToSets(_ values: NSSet)

    @objc(removeSets:)
    @NSManaged public func removeFromSets(_ values: NSSet)

}
