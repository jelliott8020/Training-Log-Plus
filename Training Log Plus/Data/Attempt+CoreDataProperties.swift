//
//  Attempt+CoreDataProperties.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 11/4/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//
//

import Foundation
import CoreData


extension Attempt {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Attempt> {
        return NSFetchRequest<Attempt>(entityName: "Attempt")
    }

    @NSManaged public var titleForTest: String?
    @NSManaged public var date: Date?
    @NSManaged public var reps: [Int]?
    @NSManaged public var sets: Int32
    @NSManaged public var weight: Double

}
