//
//  TemplatesTableViewController.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 9/6/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit

class TemplateParent_VC: UITableViewController {
    
    
    var templateList: TemplateList
    
    /*
     * Initializer
     */
    required init?(coder aDecoder: NSCoder) {
        templateList = TemplateList()
        super.init(coder: aDecoder)
    }
    
    
    /*
     * View Did Load
     */
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func addTemplateButton(_ sender: UIBarButtonItem) {
        alertWithTF()
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
    }
    
    
    /*
     * Swipe to delete
     */
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let alert = UIAlertController(title:  "Are you sure?", message: "", preferredStyle: .alert)
            
            let noButton = UIAlertAction(title: "No", style: UIAlertAction.Style.destructive, handler: nil)
            let yesButton = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { (action) -> Void in
                self.templateList.templates.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                
            } )
            
            alert.addAction(yesButton)
            alert.addAction(noButton)
            
            present(alert, animated: true, completion: nil)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
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
    
    
    func alertWithTF() {
        //Step : 1
        let alert = UIAlertController(title: "Create Template", message: "Table Information", preferredStyle: UIAlertController.Style.alert )
        
        //Step : 2
        let save = UIAlertAction(title: "Create", style: .default) { (alertAction) in
            let tempNameTxtField = alert.textFields![0] as UITextField
            let numDaysTxtField = alert.textFields![1] as UITextField
            let wendlerYesNoTxtField = alert.textFields![2] as UITextField
            let numWeeksTxtField = alert.textFields![3] as UITextField
            
            if let title = tempNameTxtField.text, let days = numDaysTxtField.text, let wen = wendlerYesNoTxtField.text, let weeks = numWeeksTxtField.text {
                
                var check = Util.checkForBlankInput(str: title, txtField: tempNameTxtField)
                check = Util.checkForBlankInput(str: days, txtField: numDaysTxtField)
                check = Util.checkForBlankInput(str: wen, txtField: wendlerYesNoTxtField)
                check = Util.checkForBlankInput(str: weeks, txtField: numWeeksTxtField)
                
                if (check) {
                    return
                }
                
                
                print(tempNameTxtField.text!)
                print("TF 1 : \(tempNameTxtField.text!)")
                
                print(numDaysTxtField.text!)
                print("TF 2 : \(numDaysTxtField.text!)")
                
                print(numDaysTxtField.text!)
                print("TF 3 : \(wendlerYesNoTxtField.text!)")
                
                print(numDaysTxtField.text!)
                print("TF 4 : \(numWeeksTxtField.text!)")
                
                
                self.performSegue(withIdentifier: "AddItemSegue", sender: self)
                
            }
            
        }
        
        alert.addTextField { (tempNameTxtField) in
            tempNameTxtField.placeholder = "Template Title:"
            tempNameTxtField.textColor = .red
        }
        
        alert.addTextField { (numDaysTxtField) in
            numDaysTxtField.placeholder = "Number of Days per Week:"
            numDaysTxtField.textColor = .blue
        }
        
        alert.addTextField { (wendlerYesNoTxtField) in
            wendlerYesNoTxtField.placeholder = "Will there be Wendler Progression?"
            wendlerYesNoTxtField.textColor = .green
        }
        
        alert.addTextField { (numWeeksTxtField) in
            numWeeksTxtField.placeholder = "Number of Weeks"
            numWeeksTxtField.textColor = .purple
        }
        
        //Step : 4
        alert.addAction(save)
        //Cancel action
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (alertAction) in }
        alert.addAction(cancel)
        //OR single line action
        //alert.addAction(UIAlertAction(title: "Cancel", style: .default) { (alertAction) in })
        
        self.present(alert, animated:true, completion: nil)
        
        print("got")
    }
    
    
    /*
     * Prepare For Segue
     *
     * Different segue changes depending on segue identifier.
     * This allows 2 different buttons to open the same VC.
     * If editing, pass the item. If adding, will create new item there.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItemSegue" {
            if let itemDetailViewController = segue.destination as? AddEdit_Template_VC {
                itemDetailViewController.delegate = self
                itemDetailViewController.templateList = templateList
            }
        } else if segue.identifier == "EditItemSegue" {
            if let itemDetailViewController = segue.destination as? AddEdit_Template_VC {
                if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                    let item = templateList.templates[indexPath.row]
                    itemDetailViewController.itemToEdit = item
                    itemDetailViewController.delegate = self
                }
            }
        }
    }
    
    
    /*
     * Configure the text for each row item.
     */
    func configureText(for cell: UITableViewCell, with item: Template) {
        if let templateCell = cell as? Template_TVCell {
            templateCell.templateTextLabel.text = item.title
        }
    }
    
    
    /*
     * Add a new template to the list
     */
    func addNewTemplate(temp: Template) {
        templateList.addTemplate(temp)
    }
    
    
    /*
     * Changes the top bar to white (battery, service provider)
     * Doesn't work for some reason
     */
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}


/*
 * Delegate
 *
 * Implements the functions that allow the New or Edited Template to be passed back
 */
extension TemplateParent_VC: Pass_AddEditTemplate_BackTo_TemplateParent_Delegate {
    
    /*
     * Cancel button will pop the view controller
     */
    func itemDetailViewControllerDidCancel(_ controller: AddEdit_Template_VC) {
        navigationController?.popViewController(animated: true)
    }
    
    
    /*
     * After adding, data is passed back
     */
    func itemDetailViewController(_ controller: AddEdit_Template_VC, didFinishAdding item: Template) {
        navigationController?.popViewController(animated: true)
        //templateList.addTemplateObj(item)
        let rowIndex = templateList.templates.count - 1
        let indexPath = IndexPath(row: rowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    
    /*
     * After editing, data is passed back
     */
    func itemDetailViewController(_ controller: AddEdit_Template_VC, didFinishEditing item: Template) {
        if let index = templateList.templates.firstIndex(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
        }
        navigationController?.popViewController(animated: true)
    }
}
