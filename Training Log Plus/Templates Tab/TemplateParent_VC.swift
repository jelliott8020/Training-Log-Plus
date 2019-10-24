//
//  TemplatesTableViewController.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 9/6/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit

class TemplateParent_VC: UITableViewController {
    
    
    var templateList: TemplateList // Items for the table
    
    
    required init?(coder aDecoder: NSCoder) {
        templateList = TemplateList()
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*****************/
        //  EDIT BUTTON  //
        /*****************/
        
        // Add an edit button to enter "edit mode"
        //navigationItem.leftBarButtonItem = editButtonItem
        //navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
        // Allows the ability to edit multiple items with edit button
        //tableView.allowsMultipleSelectionDuringEditing = true
    }
    
    
    /*
     * When user interacts with cell
     */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Prevents cell from being opened while in edit mode
        if tableView.isEditing {
            return
        }
        
        // Animation to show they interacted
        tableView.deselectRow(at: indexPath, animated: true)
        
        // ********************* //
        // Remove/add checkmarks //
        // ********************* //
        // Removes or adds checkmarks to each cell
        //        if let cell = tableView.cellForRow(at: indexPath) {
        //            let item = templateList.templates[indexPath.row]
        //            configureCheckmark(for: cell, with: item)
        //
        //            // Makes the highlighting of cell when tapping go away
        //
        //        }
    }
    
    
    /*
     * Swipe to delete
     */
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        templateList.templates.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    
    /*
     * Tell the table how many cells to display
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return templateList.templates.count
    }
    
    
    /*
     * Called everytime a table needs a cell
     * Configure cell to show certain data
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TemplateCell", for: indexPath)
        
        // Manipulating the data on the label in the cell
        let item = templateList.templates[indexPath.row]
        configureText(for: cell, with: item)
        
        //configureCheckmark(for: cell, with: item)
        
        return cell
    }
    
    
    /*
     * Different segue changes depending on segue identifier
     * This allows 2 different buttons to open the same VC
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItemSegue" {
            if let itemDetailViewController = segue.destination as? AddEditTemplate_VC {
                itemDetailViewController.delegate = self
                itemDetailViewController.templateList = templateList
            }
        } else if segue.identifier == "EditItemSegue" {
            if let itemDetailViewController = segue.destination as? AddEditTemplate_VC {
                if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                    let item = templateList.templates[indexPath.row]
                    itemDetailViewController.itemToEdit = item
                    itemDetailViewController.delegate = self
                }
            }
        }
    }
    
    
    /*
     * Configure the text for each row item
     */
    func configureText(for cell: UITableViewCell, with item: TemplateItem) {
        if let templateCell = cell as? TemplateList_TVCell {
            templateCell.templateTextLabel.text = item.templateTitle
        }
    }
    
    
    /*
     * Add a new template to the list
     */
    func addNewTemplate(temp: String) {
        templateList.addTemplate(temp: temp)
    }
    
    
    /*
     * Changes the top bar to white (battery, service provider)
     * Doesn't work for some reason
     */
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // ********************* //
    //   Toggle check marks  //
    // ********************* //
    //    func configureCheckmark(for cell: UITableViewCell, with item: TemplateItemObject) {
    //        guard let checkmark = cell.viewWithTag(1001) as? UILabel else {
    //            return
    //        }
    //
    //        if item.checked {
    //            checkmark.text = "√"
    //        } else {
    //            checkmark.text = ""
    //        }
    //        item.toggleChecked()
    //    }
    
    
    // ********************* //
    // Old add button action //
    // ********************* //
    //    @IBAction func addItem(_ sender: Any) {
    //        let newRowIndex = templateList.templates.count
    //
    //        // This increases the size but we dont need
    //        // to use it, so assign it to _
    //        _ = templateList.newTemplate()
    //
    //        let indexPath = IndexPath(row: newRowIndex, section: 0)
    //
    //        // insertRows requires an array, so just put
    //        // the one item into an array
    //        let indexPaths = [indexPath]
    //
    //        tableView.insertRows(at: indexPaths, with: .automatic)
    //    }
    
    
    // ******************* //
    // Set editing mode on //
    // ******************* //
    //    override func setEditing(_ editing: Bool, animated: Bool) {
    //        super.setEditing(editing, animated: true)
    //        tableView.setEditing(tableView.isEditing, animated: true)
    //    }
    
    
    // ********************************* //
    // Allows moving cells in edit mode  //
    // ********************************* //
    
    //    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath:          IndexPath, to destinationIndexPath: IndexPath) {
    //        templateList.move(item: templateList.templates[sourceIndexPath.row], to:          destinationIndexPath.row)
    //        //tableView.reloadData()
    //    }
    
    
    // ********************************** //
    // Multiple select and delete circles //
    // ********************************** //
    //    @IBAction func deleteItems(_ sender: Any) {
    //        if let selectedRows = tableView.indexPathsForSelectedRows {
    //            var items = [TemplateItemObject]()
    //            for indexPath in selectedRows {
    //                items.append(templateList.templates[indexPath.row])
    //            }
    //            templateList.remove(items: items)
    //            tableView.beginUpdates()
    //            tableView.deleteRows(at: selectedRows, with: .automatic)
    //            tableView.endUpdates()
    //        }
    //    }
}


// Delegate from the item detail VC
extension TemplateParent_VC: ItemDetail_VCDelegate {
    
    
    /*
     * Cancel button will pop the view controller
     */
    func itemDetailViewControllerDidCancel(_ controller: AddEditTemplate_VC) {
        navigationController?.popViewController(animated: true)
    }
    
    
    /*
     *
     */
    func itemDetailViewController(_ controller: AddEditTemplate_VC, didFinishAdding item: TemplateItem) {
        navigationController?.popViewController(animated: true)
        let rowIndex = templateList.templates.count - 1
        let indexPath = IndexPath(row: rowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    
    /*
     *
     */
    func itemDetailViewController(_ controller: AddEditTemplate_VC, didFinishEditing item: TemplateItem) {
        if let index = templateList.templates.firstIndex(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
        }
        navigationController?.popViewController(animated: true)
    }
}
