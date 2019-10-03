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
    var isWendler: Bool
    var cues: [String] = []
    

    init(name: String, isWendler: Bool) {
        self.name = name
        self.isWendler = isWendler
        getData(name)
    }
    

    func getData(_ name: String) {
        // fill in the attempts list here
        // fill in cues list here
        // check if its empty
    }
    
    func getAttemptAtDate(date: Date) {
        // Find an attempt object with the certain date
    }
    
}
