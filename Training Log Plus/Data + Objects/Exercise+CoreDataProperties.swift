//
//  Exercise+CoreDataProperties.swift
//  Training Log Plus
//
//  Created by Elliott, Josh on 11/10/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//
//

import Foundation
import CoreData


extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }

    @NSManaged public var bodypart: String
    @NSManaged public var name: String
    @NSManaged public var progression: Progression?

}
