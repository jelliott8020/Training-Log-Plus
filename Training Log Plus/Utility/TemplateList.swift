//
//  TemplateList.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 9/8/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import Foundation

/**
 *  Class to keep the list of template items
 */
class TemplateList {
    
    var templates: [TemplateItem] = []
    
    init() {
        let temp1 = TemplateItem()
        temp1.title = "placeholder1"
        temp1.listOfWorkouts = addWorkouts()
        templates.append(temp1)
        
        let temp2 = TemplateItem()
        temp2.title = "placeholder1"
        temp2.listOfWorkouts = addWorkouts()
        templates.append(temp2)
        
        let temp3 = TemplateItem()
        temp3.title = "placeholder1"
        temp3.listOfWorkouts = addWorkouts()
        templates.append(temp3)
        
    }
    
    
    /*
     Add Template: Adds a template object to array
     */
    func addTemplate(_ temp: TemplateItem) {
        templates.append(temp);
    }
    
    
    /*
     New Template: Adds a new blank template object to array
     */
    func newTemplate() -> TemplateItem {
        let item = TemplateItem()
        templates.append(item)
        return item
    }
    
    
    /*
     Move Template: Moves template to a different index in array
     */
    func move(item: TemplateItem, to index: Int) {
        guard let currentIndex = templates.firstIndex(of: item) else {
            return
        }
        templates.remove(at: currentIndex)
        templates.insert(item, at: index)
    }
    
    
    /*
     Remove Template: Removes a template from the array
     */
    func remove(items: [TemplateItem]) {
        for item in items {
            if let index = templates.firstIndex(of: item) {
                templates.remove(at: index)
            }
        }
    }
    
    
    /*
     Add Workouts: Create WorkoutDay array, add random stuff, return
     */
    private func addWorkouts() -> [WorkoutDay] {
        var exArg: [WorkoutDay] = []
        let ex1 = WorkoutDay(title: randTitle())
        let ex2 = WorkoutDay(title: randTitle())
        let ex3 = WorkoutDay(title: randTitle())
        let ex4 = WorkoutDay(title: randTitle())
        exArg.append(ex1)
        exArg.append(ex2)
        exArg.append(ex3)
        exArg.append(ex4)
        
        return exArg
    }
    
    
    /*
     Random Title: Creates and returns a random WorkoutDay title
     */
    private func randTitle() -> String {
        let titles = ["Upper Lower", "3 Day Full Body", "2 Day Full Body w/ Running", "Wendler 531", "5 Day Bodybuilding"]
        let ranNum = Int.random(in: 0 ... titles.count-1)
        return titles[ranNum]
    }
}
