//
//  ChangeTemplateViewController.swift
//  Training Log Plus
//
//  Created by Elliott, Josh on 10/16/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit


protocol Pass_SelectedTemplate_BackTo_Workout_Delegate: class {
    func passTemplateBack(_ controller: ChangeTemplate_VC, didSelect item: Template)
}

class ChangeTemplate_VC: UITableViewController {
    
    var templateList: [Template] = []
    
    weak var delegate: Pass_SelectedTemplate_BackTo_Workout_Delegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataManager.getTemplate(tempData: &templateList)
    }
    
    @IBAction func cancel(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    /*
     * Configure the text for each row item.
     */
    func configureText(for cell: UITableViewCell, with item: Template) {
        if let templateCell = cell as? ChangeTemplate_TVCell {
            templateCell.cellLabel.text = item.name
        }
    }

}

/**
 * TABLE VIEW
 */
extension ChangeTemplate_VC {
    
    /*
     * When user interacts with cell
     */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.passTemplateBack(self, didSelect: templateList[indexPath.row])
        dismiss(animated: true, completion: nil)
    }
    
    /*
     * Tell the table how many cells to display
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return templateList.count
    }
    
    /*
     * Called everytime a table needs a cell
     * Configure cell to show certain data
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectNewTemplateCell", for: indexPath)
        
        // Manipulating the data on the label in the cell
        let item = templateList[indexPath.row]
        configureText(for: cell, with: item)
        
        //configureCheckmark(for: cell, with: item)
        
        return cell
    }
}
