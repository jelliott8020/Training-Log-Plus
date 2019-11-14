//
//  WendlerProgression+CoreDataClass.swift
//  Training Log Plus
//
//  Created by Elliott, Josh on 11/14/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//
//

import Foundation
import CoreData


public class Wen_Progression: NSManagedObject {
    
    func getSets(weight: Double) -> [Sets] {
        
        var sets: [Sets] = []
        let wt = Util.rounder(weight, toNearest: 5)
        
       
        if name == "531 Base (3 sets)" {
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
