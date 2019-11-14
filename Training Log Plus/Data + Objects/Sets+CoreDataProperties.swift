//
//  Sets+CoreDataProperties.swift
//  Training Log Plus
//
//  Created by Elliott, Josh on 11/14/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//
//

import Foundation
import CoreData


extension Sets {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Sets> {
        return NSFetchRequest<Sets>(entityName: "Sets")
    }

    @NSManaged public var reps: Int32
    @NSManaged public var weight: Double
    @NSManaged public var attempt: Attempt?
    @NSManaged public var wenProgression: Wen_Progression?
    @NSManaged public var bbProgression: BB_Progression?

}
