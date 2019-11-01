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
    
    var alertTitle: String?
    var alertDays: Int?
    var alertWen: Bool?
    var alertWeeks: Int?
    
    //var wendlerPicker = UIPickerView()
    //var wendlerData: [String] = []
    var selectedWendler: String?
    
    var tempNameTxtField: UITextField?
    var numDaysTxtField: UITextField?
    var wendlerYesNoTxtField: UITextField?
    var numWeeksTxtField: UITextField?
    
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
        //wendlerData = Util.getYesOrNoForPickerData()
        //self.wendlerPicker.delegate = self
    }
    
    
    @IBAction func addTemplateButton(_ sender: UIBarButtonItem) {
        addButtonAlert()
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
    
    
    func addButtonAlert() {
        //Step : 1
        let alert = UIAlertController(title: "Create Template", message: "Table Information", preferredStyle: UIAlertController.Style.alert )
        
        
        
        
        //Step : 2
        let save = UIAlertAction(title: "Create", style: .default) { (alertAction) in
            
            self.tempNameTxtField = alert.textFields![0] as UITextField
            self.numDaysTxtField = alert.textFields![1] as UITextField
            self.wendlerYesNoTxtField = alert.textFields![2] as UITextField
            self.numWeeksTxtField = alert.textFields![3] as UITextField
            
            if let title = self.tempNameTxtField?.text, let days = self.numDaysTxtField?.text, let wen = self.wendlerYesNoTxtField?.text, let weeks = self.numWeeksTxtField?.text {
                
                var check = Util.checkForBlankInput(str: title, txtField: self.tempNameTxtField!)
                check = Util.checkForBlankInput(str: days, txtField: self.numDaysTxtField!)
                check = Util.checkForBlankInput(str: wen, txtField: self.wendlerYesNoTxtField!)
                check = Util.checkForBlankInput(str: weeks, txtField: self.numWeeksTxtField!)
                
                if Int(days)! <= 1 {
                    let alert = UIAlertController(title: "Invalid entry", message: "Days less than 1", preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "Ok", style: .default) { (alertAction) in self.addButtonAlert()}
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                    
                }
                
                self.alertTitle = title
                self.alertDays = Int(days)
                self.alertWeeks = Int(weeks)
                
                if (wen.lowercased() == "yes") {
                    self.alertWen = true
                } else {
                    self.alertWen = false
                }
                
                if (check) {
                    return
                }
                
                self.performSegue(withIdentifier: "AddItemSegue", sender: self)
            }
        }
        
        //let toolBar = createToolbarDoneButton()
        
        alert.addTextField { (tempNameTxtField) in
            tempNameTxtField.placeholder = "Template Title:"
            //tempNameTxtField.inputAccessoryView = toolBar
        }
        
        alert.addTextField { (numDaysTxtField) in
            numDaysTxtField.placeholder = "Number of Days per Week:"
            numDaysTxtField.keyboardType = UIKeyboardType.numberPad
            //numDaysTxtField.inputAccessoryView = toolBar
        }
        
        alert.addTextField { (wendlerYesNoTxtField) in
            wendlerYesNoTxtField.placeholder = "Will there be Wendler Progression?"
            //wendlerYesNoTxtField.inputView = self.wendlerPicker
            //wendlerYesNoTxtField.inputAccessoryView = toolBar
        }
        
        alert.addTextField { (numWeeksTxtField) in
            numWeeksTxtField.placeholder = "Number of Weeks"
            numWeeksTxtField.keyboardType = UIKeyboardType.numberPad
            //numWeeksTxtField.inputAccessoryView = toolBar
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (alertAction) in }
        
        alert.addAction(save)
        alert.addAction(cancel)
        
        self.present(alert, animated:true, completion: nil)
        
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
            if let addTempVC = segue.destination as? AddEdit_Template_VC {
                addTempVC.delegate = self
                addTempVC.templateList = templateList
                addTempVC.passedTitle = alertTitle
                addTempVC.passedWen = alertWen
                addTempVC.passedDays = alertDays
                addTempVC.passedWeeks = alertWeeks
            }
        } else if segue.identifier == "EditItemSegue" {
            if let editTempVC = segue.destination as? AddEdit_Template_VC {
                if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                    let item = templateList.templates[indexPath.row]
                    editTempVC.itemToEdit = item
                    editTempVC.delegate = self
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

/*
 * Utility Functions
 */
extension TemplateParent_VC {
    
    
    /*
     * Create Tool Bar Done Button
     *
     * Creates done buttons for the toolbars
     */
    func createToolbarDoneButton() -> UIToolbar {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonAction))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    
    
    /*
     * Done Button Action
     *
     * Tells the toolbar what to do when done is tapped
     */
    @objc func doneButtonAction() {
        if tempNameTxtField!.isEditing {
            tempNameTxtField!.resignFirstResponder()
            numDaysTxtField!.becomeFirstResponder()
        } else if numDaysTxtField!.isEditing {
            numDaysTxtField!.resignFirstResponder()
            wendlerYesNoTxtField!.becomeFirstResponder()
        } else if wendlerYesNoTxtField!.isEditing {
            wendlerYesNoTxtField!.resignFirstResponder()
            numWeeksTxtField!.becomeFirstResponder()
        } else if numWeeksTxtField!.isEditing {
            numWeeksTxtField!.resignFirstResponder()
            self.performSegue(withIdentifier: "AddItemSegue", sender: self)
        }
    }
    
//    /*
//     * Show keyboard automatically without tapping
//     */
//    override func viewWillAppear(_ animated: Bool) {
//
//        //        if itemToEdit != nil {
//        //            return
//        //        }
//        templateTitleTextField.becomeFirstResponder()
//    }
}

///*
// * Picker
// */
//extension TemplateParent_VC: UIPickerViewDataSource, UIPickerViewDelegate {
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        var returnInt = 0
//
//        if pickerView == wendlerPicker {
//            returnInt = wendlerData.count
//        }
//
//        return returnInt
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//
//        var returnStr = ""
//
//        if pickerView == wendlerPicker {
//            returnStr = wendlerData[row]
//        }
//
//        return returnStr
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if pickerView == wendlerPicker {
//            selectedWendler = wendlerData[row]
//            wendlerYesNoTxtField?.text = selectedWendler
//        }
//    }
//}
