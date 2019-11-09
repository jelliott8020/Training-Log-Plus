//
//  Progression+CoreDataProperties.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 11/8/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//
//

import Foundation
import CoreData


extension Progression {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Progression> {
        return NSFetchRequest<Progression>(entityName: "Progression")
    }


}
