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
        for _ in 0...20 {
            _ = newTemplate()
        }
    }
    
    // Creates a new template item
    func newTemplate() -> TemplateItem {
        let item = TemplateItem()
        item.text = randTitle()
        item.checked = true
        templates.append(item)
        return item
    }
    
    // Creates a random title for a template item
    private func randTitle() -> String {
        var titles = ["Upper Lower", "3 Day Full Body", "2 Day Full Body w/ Running", "Wendler 531", "5 Day Bodybuilding"]
        let ranNum = Int.random(in: 0 ... titles.count-1)
        return titles[ranNum]
    }
    
}
