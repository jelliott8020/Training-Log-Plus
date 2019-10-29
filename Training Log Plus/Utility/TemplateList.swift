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
    
    var templates: [Template] = []
    
    init() {
        let temp1 = Template()
        temp1.title = "Template Title 1"
        temp1.listOfWorkouts = addWorkouts()
        temp1.numDaysOfWeek = temp1.listOfWorkouts.count
        temp1.numOfWeeks = 1
        templates.append(temp1)
        
        let temp2 = Template()
        temp2.title = "Template Title 2"
        temp2.listOfWorkouts = addWorkouts()
        temp2.numDaysOfWeek = temp2.listOfWorkouts.count
        temp1.numOfWeeks = 2
        templates.append(temp2)
        
        let temp3 = Template()
        temp3.title = "Template Title 3"
        temp3.listOfWorkouts = addWorkouts()
        temp3.numDaysOfWeek = temp3.listOfWorkouts.count
        temp1.numOfWeeks = 3
        templates.append(temp3)
        
    }
    
    
    /*
     Add Template: Adds a template object to array
     */
    func addTemplate(_ temp: Template) {
        templates.append(temp);
    }
    
    
    /*
     New Template: Adds a new blank template object to array
     */
    func newTemplate() -> Template {
        let item = Template()
        templates.append(item)
        return item
    }
    
    
    /*
     Move Template: Moves template to a different index in array
     */
    func move(item: Template, to index: Int) {
        guard let currentIndex = templates.firstIndex(of: item) else {
            return
        }
        templates.remove(at: currentIndex)
        templates.insert(item, at: index)
    }
    
    
    /*
     Remove Template: Removes a template from the array
     */
    func remove(items: [Template]) {
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
        let titles = ["Workout Day 1", "Workout Day 2", "Workout Day 3", "Workout Day 4"]
        let ranNum = Int.random(in: 0 ... titles.count-1)
        return titles[ranNum]
    }
}
