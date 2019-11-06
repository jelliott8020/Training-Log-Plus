//
//  Exercise+CoreDataClass.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 11/4/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//
//

import Foundation
import CoreData


public class Exercise: NSManagedObject {

     var srtWeight : Int {
        get { return Int(startingWeight) }
        set { startingWeight = Int32(newValue) }
     }
    
    func returnDisplayString() -> String {
        if let prog = progression, !prog.isEmpty {
            return name + " (\(prog))"
        }
        return name
    }
}
