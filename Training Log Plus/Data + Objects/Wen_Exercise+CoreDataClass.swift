//
//  Wen_Exercise+CoreDataClass.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 11/8/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//
//

import Foundation
import CoreData


public class Wen_Exercise: Exercise {
    
    //     var currTM : Int {
    //        get { return Int(currentTM) }
    //        set { currentTM = Int32(newValue) }
    //     }

//        func returnDisplayString() -> String {
//            if let prog = progression, !prog.isEmpty {
//                return name + " (\(prog))"
//            }
//            return name
//        }
    
    override func getList() -> NSSet {
        if let tm = trainingMaxes {
            return tm
        }
        print("training maxes empty")
        return NSSet.init()
    }

}
