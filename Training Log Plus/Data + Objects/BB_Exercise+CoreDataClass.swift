//
//  BB_Exercise+CoreDataClass.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 11/8/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//
//

import Foundation
import CoreData


public class BB_Exercise: Exercise {
    
     var srtWeight : Int {
        get { return Int(startingWeight) }
        set { startingWeight = Int32(newValue) }
     }

//    func returnDisplayString() -> String {
//        if let prog = progression, !prog.isEmpty {
//            return name + " (\(prog))"
//        }
//        return name
//    }
    
    override func getList() -> NSSet {
        if let att = attemptList {
            return att
        }
        print("attemp list empty")
        return NSSet.init()
    }

}
