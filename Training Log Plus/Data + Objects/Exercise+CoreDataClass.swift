//
//  Exercise+CoreDataClass.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 11/8/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//
//

import Foundation
import CoreData


public class Exercise: NSManagedObject {
    
    func getList() -> NSSet {
        assert(false, "Must be overridden")
        return NSSet.init()
    }
    
}
