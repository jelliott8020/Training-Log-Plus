//
//  PersonalRecord+CoreDataClass.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 11/8/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//
//

import UIKit
import CoreData


public class PersonalRecord: NSManagedObject {
    
    func getEstTM() -> Double {
        return (weight * reps * 0.0333) + weight
    }
    
    /*
     * Get Training Max Display String with Date
     */
    func getPrDisplayString() -> NSMutableAttributedString {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let dateFormatted = formatter.string(from: date!)
        
        let dateStr = "Date: " + dateFormatted
        let tmString = "  | TM: " + String(format: "%.0f", getEstTM())
        let weightStr = "  | Weight: " + String(format: "%.0f", weight)
        let repsStr = "  |  Reps: " + String(format: "%.0f", reps)
        
        let totalString = dateStr + weightStr + repsStr + tmString
        
        let strNumber: NSString = totalString as NSString
        let tmRange = (strNumber).range(of: tmString)
        let dateRange = (strNumber).range(of: dateStr)
        let attribute = NSMutableAttributedString.init(string: strNumber as String)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: tmRange)
        attribute.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 17.0), range: tmRange)
        attribute.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 17.0), range: dateRange)
        
        return attribute
    }

}
