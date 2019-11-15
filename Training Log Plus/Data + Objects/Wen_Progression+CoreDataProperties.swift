//
//  Wen_Progression+CoreDataProperties.swift
//  Training Log Plus
//
//  Created by Elliott, Josh on 11/14/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//
//

import Foundation
import CoreData


extension Wen_Progression {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Wen_Progression> {
        return NSFetchRequest<Wen_Progression>(entityName: "Wen_Progression")
    }

    @NSManaged public var name: String
    @NSManaged public var week: Int32
    @NSManaged public var sets: Set<Sets>
    @NSManaged public var exercise: Wen_Exercise?

}

// MARK: Generated accessors for sets
extension Wen_Progression {

    @objc(addSetsObject:)
    @NSManaged public func addToSets(_ value: Sets)

    @objc(removeSetsObject:)
    @NSManaged public func removeFromSets(_ value: Sets)

    @objc(addSets:)
    @NSManaged public func addToSets(_ values: NSSet)

    @objc(removeSets:)
    @NSManaged public func removeFromSets(_ values: NSSet)

}
