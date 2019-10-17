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
        for _ in 0...5 {
            _ = newTemplate()
        }
    }
    
    func addTemplate(temp: String) {
        let item = TemplateItem()
        item.text = temp
        //item.checked = true
        templates.append(item)
    }
    
    // Creates a new template item
    func newTemplate() -> TemplateItem {
        let item = TemplateItem()
        item.text = randTitle()
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
    
    // Creates a random title for a template item
    private func randTitle() -> String {
        let titles = ["Upper Lower", "3 Day Full Body", "2 Day Full Body w/ Running", "Wendler 531", "5 Day Bodybuilding"]
        let ranNum = Int.random(in: 0 ... titles.count-1)
        return titles[ranNum]
    }
    
}
