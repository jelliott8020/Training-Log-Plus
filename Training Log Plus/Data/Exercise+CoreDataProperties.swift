//
//  Exercise+CoreDataProperties.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 11/4/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//
//

import Foundation
import CoreData


extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }

    @NSManaged public var name: String
    @NSManaged public var bodyPart: String
    @NSManaged public var progression: String
    @NSManaged public var startingWeight: Int32
    @NSManaged public var attemptList: [Attempt]

}
