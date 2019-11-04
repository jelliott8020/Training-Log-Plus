//
//  Exercise.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 9/25/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import Foundation
import CoreData


class Exercise: NSObject {
    
    var name: String?
    var attemptList: [Attempt] = []
    var isWendler: Bool?
    var cues: [String] = []
    var cellDisplayTitle: String?
    
    var bodyPart: String?
    var progression: String?
    
    func addAttempt(_ obj: Attempt) {
        attemptList.append(obj)
    }
    
    func addBlankAttempt() {
        let item = Attempt()
        attemptList.append(item)
    }
    
}
