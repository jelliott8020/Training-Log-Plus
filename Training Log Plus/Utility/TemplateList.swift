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
        addTemplate("placeholder1")
        addTemplate("placeholder2")
    }
    
    func addTemplate(_ temp: String) {
        let item = TemplateItem()
        item.templateTitle = temp
        item.listOfWorkouts = addExercises()
        //item.checked = true
        templates.append(item)
    }
    
    func addTemplateObj(_ temp: TemplateItem) {
        templates.append(temp);
    }
    
    // Creates a new template item
    func newTemplate() -> TemplateItem {
        let item = TemplateItem()
        //item.templateTitle = randTitle()
        //item.checked = true
        templates.append(item)
        return item
    }
    
    func move(item: TemplateItem, to index: Int) {
        guard let currentIndex = templates.firstIndex(of: item) else {
            return
        }
        templates.remove(at: currentIndex)
        templates.insert(item, at: index)
    }
    
    func remove(items: [TemplateItem]) {
        for item in items {
            if let index = templates.firstIndex(of: item) {
                templates.remove(at: index)
            }
        }
    }
    
    private func addExercises() -> [WorkoutDay] {
        var exArg: [WorkoutDay] = []
        let ex1 = WorkoutDay(title: "Upper")
        let ex2 = WorkoutDay(title: "Lower")
        let ex3 = WorkoutDay(title: "Chest")
        let ex4 = WorkoutDay(title: "Back")
        exArg.append(ex1)
        exArg.append(ex2)
        exArg.append(ex3)
        exArg.append(ex4)
        
        return exArg
    }
    
    
    // Creates a random title for a template item
    private func randTitle() -> String {
        let titles = ["Upper Lower", "3 Day Full Body", "2 Day Full Body w/ Running", "Wendler 531", "5 Day Bodybuilding"]
        let ranNum = Int.random(in: 0 ... titles.count-1)
        return titles[ranNum]
    }
    
}