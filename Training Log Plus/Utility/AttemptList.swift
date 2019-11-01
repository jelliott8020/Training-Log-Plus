//
//  AttemptList.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 10/31/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import Foundation

class AttemptList {
    
    var attempts: [Attempt] = []
    
    func addAttemptObj(_ obj: Attempt) {
        attempts.append(obj)
    }
    
    func addAttemptObjWithTitle(_ title: String) {
        let item = Attempt()
        item.titleForTest = "TestAttempt1"
        attempts.append(item)
    }
    
}
