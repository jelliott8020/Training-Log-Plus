//
//  TemplatesTableViewController.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 9/6/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit

class TemplatesTableViewController: UITableViewController {
    
    // List of template items
    var templateList: TemplateList
    
    // Add item button
    @IBAction func addItem(_ sender: Any) {
        let newRowIndex = templateList.templates.count
        
        // This increases the size but we dont need
        // to use it, so assign it to _
        _ = templateList.newTemplate()
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        
        // insertRows requires an array, so just put
        // the one item into an array
        let indexPaths = [indexPath]
        
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    // Constructor
    required init?(coder aDecoder: NSCoder) {
        templateList = TemplateList()
        super.init(coder: aDecoder)
    }
    
    // View loader
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set large title bar
        //navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // Toggles check mark on item
    func configureCheckmark(for cell: UITableViewCell, with item: TemplateItem) {
        if item.checked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        item.toggleChecked()
    }
    
    // Configures the text for each row item
    func configureText(for cell: UITableViewCell, with item: TemplateItem) {
        if let label = cell.viewWithTag(1000) as? UILabel {
            label.text = item.text
        }
    }
    
    // When user interacts with the cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Removes or adds checkmarks to each cell
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = templateList.templates[indexPath.row]
            configureCheckmark(for: cell, with: item)
            
            // Makes the highlighting of cell when tapping go away
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    // Changes top bar to white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // Swipe to delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        templateList.templates.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    // Tell table how many cells to display
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return templateList.templates.count
    }
    
    
    // Called everytime a table needs a cell, in this method we configure cell to show
    // certain kinds of data
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TemplateCell", for: indexPath)
        
        // Manipulating the data on the label in the cell
        let item = templateList.templates[indexPath.row]
        configureText(for: cell, with: item)
        
        configureCheckmark(for: cell, with: item)
        
        return cell
    }
}


// ********************************************* //
// You can do this below in order to encapsulate //
// certain elements of a table view controller.  //
// ********************************************* //


//// ********* Table Delegate *********** //
//// Controls when user interacts with the table
//extension TemplatesTableViewController: UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        // Removes or adds checkmarks to each cell
//        if let cell = tableView.cellForRow(at: indexPath) {
//            let item = templateList.templates[indexPath.row]
//            configureCheckmark(for: cell, with: item)
//
//            // Makes the highlighting of cell when tapping go away
//            tableView.deselectRow(at: indexPath, animated: true)
//        }
//    }
//}

//// ********* Table Data Source ********* //
//// Gives the table its data
//extension TemplatesTableViewController: UITableViewDataSource {
//
//    // Tell table how many cells to display
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return templateList.templates.count
//    }
//
//
//    // Called everytime a table needs a cell, in this method we configure cell to show
//    // certain kinds of data
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TemplateCell", for: indexPath)
//
//        // Manipulating the data on the label in the cell
//        let item = templateList.templates[indexPath.row]
//        configureText(for: cell, with: item)
//
//        configureCheckmark(for: cell, with: item)
//
//        return cell
//    }
//
//}
