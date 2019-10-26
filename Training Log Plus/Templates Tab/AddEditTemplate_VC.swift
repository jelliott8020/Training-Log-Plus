//
//  AddItemTableViewController.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 9/8/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit


protocol ItemDetail_VCDelegate: class {
    // User hit cancel
    func itemDetailViewControllerDidCancel(_ controller: AddEditTemplate_VC)
    // User added item
    func itemDetailViewController(_ controller: AddEditTemplate_VC, didFinishAdding item: TemplateItem)
    // User finishes editing
    func itemDetailViewController(_ controller: AddEditTemplate_VC, didFinishEditing item: TemplateItem)
}


/*
 * This class allows 2 views, an Add and Edit
 */
class AddEditTemplate_VC: UIViewController {

    // In order to use the protocol above, need a delegate
    // Any viewController that implements this protocol can be a delegate of the AddItemTableViewController
    weak var delegate: ItemDetail_VCDelegate?
    weak var templateList: TemplateList?
    weak var itemToEdit: TemplateItem?
    
    @IBOutlet weak var doneButtonOutlet: UIBarButtonItem!
    
    

    
    @IBOutlet weak var templateTitleTextField: UITextField!
    @IBOutlet weak var numDaysOfWeekTextField: UITextField!
    @IBOutlet weak var wendlerYesNoTextField: UITextField!
    @IBOutlet weak var numOfWeeksTextField: UITextField!
    @IBOutlet weak var workoutDaysTable: UITableView!
    
    @IBAction func createButton(_ sender: UIButton) {
        // Add stuff to table
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = itemToEdit {
            title = "Edit Template"
            templateTitleTextField.text = item.templateTitle
            numDaysOfWeekTextField.text = String(item.numDaysOfWeek)
            numOfWeeksTextField.text = String(item.numOfWeeks)
            
            if item.wendlerYesNo {
                wendlerYesNoTextField.text = "Yes"
            } else {
                wendlerYesNoTextField.text = "No"
            }
            
            doneButtonOutlet.isEnabled = true
        }
        
        navigationItem.largeTitleDisplayMode = .never
    }
    
    /*
     * Show keyboard automatically without tapping
     */
    override func viewWillAppear(_ animated: Bool) {
        
//        if itemToEdit != nil {
//            return
//        }
        templateTitleTextField.becomeFirstResponder()
    }
    
//    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
//        return nil
//    }
    
    @IBAction func doneButtonAction(_ sender: UIBarButtonItem) {
        // Account for editing
        
        
        if let item = itemToEdit, let tempTitle = templateTitleTextField.text, let days = numDaysOfWeekTextField.text, let wen = wendlerYesNoTextField.text, let weeks = numOfWeeksTextField.text  {
            
            if (checkForGoodInput(tempTitle, days, weeks, wen)) {
                return
            } else {
                resetTextBoxColor()
            }
            
            item.templateTitle = tempTitle
            item.numOfWeeks = Int(weeks)!
            item.numDaysOfWeek = Int(days)!

            if (wen == "Yes") {
                item.wendlerYesNo = true
            } else {
                item.wendlerYesNo = false
            }
            
            delegate?.itemDetailViewController(self, didFinishEditing: item)
            
        } else {
            if let item = templateList?.newTemplate() {
                
                if let tempTitle = templateTitleTextField.text, let days = numDaysOfWeekTextField.text, let wen = wendlerYesNoTextField.text, let weeks = numOfWeeksTextField.text {
                    
                    if (checkForGoodInput(tempTitle, days, weeks, wen)) {
                        return
                    } else {
                        resetTextBoxColor()
                    }
                    
                    item.templateTitle = tempTitle
                    item.templateTitle = tempTitle
                    item.numOfWeeks = Int(weeks)!
                    item.numDaysOfWeek = Int(days)!
                    
                    if (wen == "Yes") {
                        item.wendlerYesNo = true
                    } else {
                        item.wendlerYesNo = false
                    }
                    
                }
                //item.checked = false
                delegate?.itemDetailViewController(self, didFinishAdding: item)
            }
        }
    }
    
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    
    func resetTextBoxColor() {
        
        
        
        
        
    }
    
    func checkForGoodInput(_ tempTitle: String, _ days: String, _ weeks: String, _ wen: String) -> Bool {
        if (tempTitle == "" || weeks == "" || days == "" || wen == "") {
            
            if (tempTitle == "") {
                shakeAndRedTextField(templateTitleTextField)
            } else {
                returnToDefaultTextField(wendlerYesNoTextField)
            }
            
            if (weeks == "") {
                shakeAndRedTextField(numOfWeeksTextField)
            } else {
                returnToDefaultTextField(wendlerYesNoTextField)
            }
            
            if (days == "") {
                shakeAndRedTextField(numDaysOfWeekTextField)
            } else {
                returnToDefaultTextField(wendlerYesNoTextField)
            }
            
            
            if (wen == "" /*&& !(wen.lowercased() == "yes" || wen.lowercased() == "no")*/) {
                shakeAndRedTextField(wendlerYesNoTextField)
                
            } else if (wen.lowercased() != "yes") {
                shakeAndRedTextField(wendlerYesNoTextField)
                
            } else if (wen.lowercased() != "no") {
                shakeAndRedTextField(wendlerYesNoTextField)
                
            } else {
                returnToDefaultTextField(wendlerYesNoTextField)
                
            }
            
            
            return true
            
        }
        return false
    }
    
    func shakeAndRedTextField(_ textField: UITextField) {
        let redColor = UIColor.red
        textField.shake()
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = redColor.cgColor
    }
    
    func returnToDefaultTextField(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 5
    }
    
    

}

extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}

extension AddEditTemplate_VC: UITextFieldDelegate {
    
    // Tapping done button makes keyboard go away
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    // When user taps a key on a keyboard, this method is called
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Makes it so add button is grayed out unless text is present in textfield
        // Make sure to make add button disabled in attributes inspector
        guard let oldText = textField.text,
            let stringRange = Range(range, in: oldText) else {
                return false
        }
        
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        if newText.isEmpty {
            doneButtonOutlet.isEnabled = false
        } else {
            doneButtonOutlet.isEnabled = true
        }
        return true
    }
    
}
