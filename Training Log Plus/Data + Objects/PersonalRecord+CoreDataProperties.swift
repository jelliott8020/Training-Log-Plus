//
//  PersonalRecord+CoreDataProperties.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 11/10/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//
//

import Foundation
import CoreData


extension PersonalRecord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonalRecord> {
        return NSFetchRequest<PersonalRecord>(entityName: "PersonalRecord")
    }

    @NSManaged public var date: Date?
    @NSManaged public var reps: Double
    @NSManaged public var weight: Double

}
