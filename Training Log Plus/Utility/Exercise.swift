//
//  Exercise.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 9/25/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import Foundation


class Exercise {
    
    var name: String
    var attemptList: [Attempt] = []
    

    init(name: String) {
        self.name = name
        getData(name)
    }
    

    func getData(_ name: String) {
        // fill in the attempts list here
        // check if its empty
    }
    
    func getAttemptAtDate(date: Date) {
        // Find an attempt object with the certain date
    }
    
}
