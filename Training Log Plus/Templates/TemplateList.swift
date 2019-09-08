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
        var titles = ["New todo 1", "New todo 2", "New todo 3", "New todo 4", "New todo 5"]
        let ranNum = Int.random(in: 0 ... titles.count-1)
        return titles[ranNum]
    }
    
}
