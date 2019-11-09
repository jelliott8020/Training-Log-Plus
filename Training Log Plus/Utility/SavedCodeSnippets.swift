//
//  SavedCodeSnippets.swift
//  Training Log Plus
//
//  Created by Elliott, Josh on 10/31/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import Foundation

class SavedCodeSnippets {
    
    
    // In tableview didSelectRowAt
    
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
    
    
    
    // Sorting after querying
    
    // let sort = NSSortDescriptor(keyPath: \Friend.name, ascending: true)
    // let sort = NSSortDescriptor(key: #keyPath(Friend.name), ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))
    // request.sortDescriptors = [sort]
    
    
    
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
