//
//  TemplatesTableViewController.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 9/6/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit

class TemplatesTableViewController: UIViewController {
    
    var row0Item: TemplateItem
    var row1Item: TemplateItem
    var row2Item: TemplateItem
    var row3Item: TemplateItem
    var row4Item: TemplateItem
    
    required init?(coder aDecoder: NSCoder) {
        row0Item = TemplateItem()
        row1Item = TemplateItem()
        row2Item = TemplateItem()
        row3Item = TemplateItem()
        row4Item = TemplateItem()
        
        row0Item.text = "row0"
        row1Item.text = "row1"
        row2Item.text = "row2"
        row3Item.text = "row3"
        row4Item.text = "row4"
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func configureCheckmark(for cell: UITableViewCell, at indexPath: IndexPath) {
        if indexPath.row == 0 {
            if row0Item.checked {
                cell.accessoryType = .none
            } else {
                cell.accessoryType = .checkmark
            }
            row0Item.checked = !row0Item.checked
        } else if indexPath.row == 1 {
            if row1Item.checked {
                cell.accessoryType = .none
            } else {
                cell.accessoryType = .checkmark
            }
            row1Item.checked = !row1Item.checked
        } else if indexPath.row == 2 {
            if row2Item.checked {
                cell.accessoryType = .none
            } else {
                cell.accessoryType = .checkmark
            }
            row2Item.checked = !row2Item.checked
        } else if indexPath.row == 3 {
            if row3Item.checked {
                cell.accessoryType = .none
            } else {
                cell.accessoryType = .checkmark
            }
            row3Item.checked = !row3Item.checked
        } else if indexPath.row == 4 {
            if row4Item.checked {
                cell.accessoryType = .none
            } else {
                cell.accessoryType = .checkmark
            }
            row4Item.checked = !row4Item.checked
        }
    }
}

// ********* Table Delegate *********** //
// Controls when user interacts with the table
extension TemplatesTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Removes or adds checkmarks to each cell
        if let cell = tableView.cellForRow(at: indexPath) {
            configureCheckmark(for: cell, at: indexPath)
            
            // Makes the highlighting of cell when tapping go away
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

// ********* Table Data Source ********* //
// Gives the table its data
extension TemplatesTableViewController: UITableViewDataSource {
    // Tell table how many cells to display
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    // Called everytime a table needs a cell, in this method we configure cell to show
    // certain kinds of data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TemplateCell", for: indexPath)
        
        // Manipulating the data on the label in the cell
        if let label = cell.viewWithTag(1000) as? UILabel {
            if indexPath.row ==  0 {
                label.text = row0Item.text
            } else if indexPath.row ==  1 {
                label.text = row1Item.text
            } else if indexPath.row ==  2 {
                label.text = row2Item.text
            } else if indexPath.row ==  3 {
                label.text = row3Item.text
            } else if indexPath.row ==  4 {
                label.text = row4Item.text
            }
        }
        
        configureCheckmark(for: cell, at: indexPath)
        
        return cell
    }
    
}
