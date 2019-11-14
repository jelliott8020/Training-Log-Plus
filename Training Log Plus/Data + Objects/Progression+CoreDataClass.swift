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
        
        var sets: [Sets] = []
        let wt = Util.rounder(weight, toNearest: 5)
        
        if name == "3x5 Rep Goal" { // done
            for _ in 0...2 {
                sets.append(getSet(rp: 5, wt: wt))
            }
        } else if name == "3x5 + 2x12 @ 70%" { // done
            for _ in 0...2 {
                sets.append(getSet(rp: 5, wt: wt))
            }
            sets.append(getSet(rp: 12, wt: wt * 0.7))
            sets.append(getSet(rp: 12, wt: wt * 0.7))
        } else if name == "3x8 Rep Goal" { // done
            for _ in 0...2 {
                sets.append(getSet(rp: 8, wt: wt))
            }
        } else if name == "3x10 Rep Goal" { // done
          for _ in 0...2 {
              sets.append(getSet(rp: 10, wt: wt))
          }
        } else if name == "3x12 Rep Goal" { // done
            for _ in 0...2 {
                sets.append(getSet(rp: 12, wt: wt))
            }
        } else if name == "4x5 Rep Goal" { // done
            for _ in 0...3 {
                sets.append(getSet(rp: 5, wt: wt))
            }
        } else if name == "4x8 Rep Goal" { // done
            for _ in 0...3 {
                sets.append(getSet(rp: 8, wt: wt))
            }
        } else if name == "4x10 Rep Goal" { // done
            for _ in 0...3 {
                sets.append(getSet(rp: 10, wt: wt))
            }
        } else if name == "4x12 Rep Goal" { // done
            for _ in 0...3 {
                sets.append(getSet(rp: 12, wt: wt))
            }
        } else if name == "5x5 Rep Goal" { // done
            for _ in 0...4 {
                sets.append(getSet(rp: 5, wt: wt))
            }
        } else if name == "12/10/8/6, weight +10%" { // done
            sets.append(getSet(rp: 12, wt: wt))
            sets.append(getSet(rp: 10, wt: Util.rounder(wt + (wt * 0.1), toNearest: 5)))
            sets.append(getSet(rp: 8, wt: Util.rounder(wt + (wt * 0.2), toNearest: 5)))
            sets.append(getSet(rp: 6, wt: Util.rounder(wt + (wt * 0.3), toNearest: 5)))
        } else if name == "15/12/10/8, weight +10%" { // done
            sets.append(getSet(rp: 15, wt: wt))
            sets.append(getSet(rp: 12, wt: Util.rounder(wt + (wt * 0.1), toNearest: 5)))
            sets.append(getSet(rp: 10, wt: Util.rounder(wt + (wt * 0.2), toNearest: 5)))
            sets.append(getSet(rp: 8, wt: Util.rounder(wt + (wt * 0.3), toNearest: 5)))
        } else if name == "6/8/10/12, weight -10%" { // done
            sets.append(getSet(rp: 6, wt: wt))
            sets.append(getSet(rp: 8, wt: Util.rounder(wt - (wt * 0.1), toNearest: 5)))
            sets.append(getSet(rp: 10, wt: Util.rounder(wt - (wt * 0.2), toNearest: 5)))
            sets.append(getSet(rp: 12, wt: Util.rounder(wt - (wt * 0.3), toNearest: 5)))
        } else if name == "8/10/12/15, weight -10%" { // done
            sets.append(getSet(rp: 8, wt: wt))
            sets.append(getSet(rp: 10, wt: Util.rounder(wt - (wt * 0.1), toNearest: 5)))
            sets.append(getSet(rp: 12, wt: Util.rounder(wt - (wt * 0.2), toNearest: 5)))
            sets.append(getSet(rp: 15, wt: Util.rounder(wt - (wt * 0.3), toNearest: 5)))
        } else if name == "531 Base (3 sets)" {
            sets.append(contentsOf: getWendlerBase(week: 0, wt: wt))
            
            
        } else if name == "531 + 2x10 FSL" {
            sets.append(contentsOf: getWendlerBase(week: 0, wt: wt))
            
        } else if name == "531 + 5x5 FSL" {
            sets.append(contentsOf: getWendlerBase(week: 0, wt: wt))
            
        } else if name == "531 + BBB" {
            sets.append(contentsOf: getWendlerBase(week: 0, wt: wt))
            
        } else if name == "531 Pyramid (5 sets)" {
            sets.append(contentsOf: getWendlerBase(week: 0, wt: wt))
            
        } else if name == "531 + 2x5 FSL + 1 Joker" {
            sets.append(contentsOf: getWendlerBase(week: 0, wt: wt))
            
        } else if name == "531 + 2x5 FSL + 2 Joker" {
            sets.append(contentsOf: getWendlerBase(week: 0, wt: wt))
            
        } else if name == "531 + 2x5 FSL + 3 Joker" {
            sets.append(contentsOf: getWendlerBase(week: 0, wt: wt))
            
        } else if name == "531 Pyramid + 1 Joker" {
            sets.append(contentsOf: getWendlerBase(week: 0, wt: wt))
            
        } else if name == "531 Pyramid + 2 Joker" {
            sets.append(contentsOf: getWendlerBase(week: 0, wt: wt))
            
        } else if name == "531 Pyramid + 3 Joker" {
            sets.append(contentsOf: getWendlerBase(week: 0, wt: wt))
            
        }
        
        return sets
    }
    
    func getSet(rp: Int, wt: Double) -> Sets {
        let set = Sets(entity: Sets.entity(), insertInto: managedObjectContext)
        set.reps = Int32(rp)
        set.weight = wt
        return set
    }
    
    func getWendlerBase(week: Int, wt: Double) -> [Sets] {
        var sets: [Sets] = []
        
        if week == 1 {
            sets.append(getSet(rp: 5, wt: Util.rounder(wt * 0.6, toNearest: 5)))
            sets.append(getSet(rp: 5, wt: Util.rounder(wt * 0.7, toNearest: 5)))
            sets.append(getSet(rp: 5, wt: Util.rounder(wt * 0.8, toNearest: 5)))
        } else if week == 2 {
            sets.append(getSet(rp: 3, wt: Util.rounder(wt * 0.65, toNearest: 5)))
            sets.append(getSet(rp: 3, wt: Util.rounder(wt * 0.75, toNearest: 5)))
            sets.append(getSet(rp: 3, wt: Util.rounder(wt * 0.85, toNearest: 5)))
        } else if week == 3 {
            sets.append(getSet(rp: 5, wt: Util.rounder(wt * 0.7, toNearest: 5)))
            sets.append(getSet(rp: 3, wt: Util.rounder(wt * 0.8, toNearest: 5)))
            sets.append(getSet(rp: 1, wt: Util.rounder(wt * 0.9, toNearest: 5)))
        }
        
        return sets
    }
    
    
}
