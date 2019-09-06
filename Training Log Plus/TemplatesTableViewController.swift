//
//  TemplatesTableViewController.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 9/6/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit

class TemplatesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // Tell table how many cells to display
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1000
    }
    
    
    // Called everytime a table needs a cell, in this method we configure cell to show
    // certain kinds of data
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TemplateCell", for: indexPath)
        
        if let label = cell.viewWithTag(1000) as? UILabel {
            if indexPath.row % 5 ==  0 {
                label.text = "0"
            } else if indexPath.row % 5 ==  1 {
                label.text = "1"
            } else if indexPath.row % 5 ==  2 {
                label.text = "2"
            } else if indexPath.row % 5 ==  3 {
                label.text = "3"
            } else if indexPath.row % 5 ==  4 {
                label.text = "4"
            }
        }
        
        return cell
    }

}
