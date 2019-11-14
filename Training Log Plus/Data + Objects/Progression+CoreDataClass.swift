//
//  Progression+CoreDataClass.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 11/8/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//
//

import Foundation
import CoreData


public class Progression: NSManagedObject {

    
    func getSets(weight: Double) -> [Sets] {
        
        let sets: [Sets] = []
        
        if name == "3x5 Rep Goal" {
            for _ in 0...2 {
                sets.append(getSet(rp: 5, wt: weight))
            }
            
        } else if name == "3x5 + 2x12 @ 70%" {
            
            
        } else if name == "3x8 Rep Goal" {
            
            
        } else if name == "3x10 Rep Goal" {
          
            
        } else if name == "3x12 Rep Goal" {
            
            
        } else if name == "4x5 Rep Goal" {
            
            
        } else if name == "4x8 Rep Goal" {
            
            
        } else if name == "4x10 Rep Goal" {
            
            
        } else if name == "4x12 Rep Goal" {
            
            
        } else if name == "5x5 Rep Goal" {
            
            
        } else if name == "25 reps over 3 sets" {
            
            
        } else if name == "25 reps over 5 sets" {
            
            
        } else if name == "12/10/8/6, weight +10%" {
            
            
        } else if name == "15/12/10/8, weight +10%" {
            
            
        } else if name == "6/8/10/12, weight -10%" {
            
            
        } else if name == "8/10/12/15, weight -10%" {
            
            
        } else if name == "531 Base (3 sets)" {
            
            
        } else if name == "531 + 2x10 FSL" {
            
            
        } else if name == "531 + 5x5 FSL" {
            
            
        } else if name == "531 + BBB" {
            
            
        } else if name == "531 Pyramid (5 sets)" {
            
            
        } else if name == "531 + 2x5 FSL + 1 Joker" {
            
            
        } else if name == "531 + 2x5 FSL + 2 Joker" {
            
            
        } else if name == "531 + 2x5 FSL + 3 Joker" {
            
            
        } else if name == "531 Pyramid + 1 Joker" {
            
            
        } else if name == "531 Pyramid + 2 Joker" {
            
            
        } else if name == "531 Pyramid + 3 Joker" {
            
            
        }
    }
    
    func getSet(rp: Int, wt: Double) -> Sets {
        let set = Sets(entity: Sets.entity(), insertInto: managedObjectContext)
        set.reps = Int32(rp)
        set.weight = wt
        return set
    }
    
    
}
