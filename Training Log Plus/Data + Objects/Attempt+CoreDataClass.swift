//
//  Attempt+CoreDataClass.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 11/8/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//
//

import UIKit
import CoreData


public class Attempt: NSManagedObject {
    
    /*
     * Get Training Max Display String with Date
     */
    func getAttemptDisplayString() -> NSMutableAttributedString {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let dateFormatted = formatter.string(from: date!)
        
        let setsArg = Array(sets)
        
        let dateStr = dateFormatted
        let weightStr = "  @  " + String(format: "%.0f", setsArg[0].weight)
        let repsStr = "  |  " + String(format: "%.0f", setsArg[0].reps)
        
        let totalString = dateStr + repsStr + weightStr
        
        let strNumber: NSString = totalString as NSString
        let dateRange = (strNumber).range(of: dateStr)
        let repsRange = (strNumber).range(of: repsStr)
        let attribute = NSMutableAttributedString.init(string: strNumber as String)
        attribute.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 17.0), range: repsRange)
        attribute.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 17.0), range: dateRange)
        
        return attribute
    }
    

}
