//
//  AddItemTableViewController.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 9/8/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit


protocol ItemDetailViewControllerDelegate: class {
    // User hit cancel
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController)
    // User added item
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: TemplateItemObject)
    // User finishes editing
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: TemplateItemObject)
}

class ItemDetailViewController: UITableViewController {

    // In order to use the protocol above, need a delegate
    // Any viewController that implements this protocol can be a delegate of the AddItemTableViewController
    weak var delegate: ItemDetailViewControllerDelegate?
    
    weak var templateList: TemplateList?
    weak var itemToEdit: TemplateItemObject?
    
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    
    // Add item 'cancel' button
    @IBAction func cancel(_ sender: Any) {
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    
    // Add item 'done' button
    @IBAction func done(_ sender: Any) {
        // Account for editing
        if let item = itemToEdit, let text = textField.text {
            item.text = text
            delegate?.itemDetailViewController(self, didFinishEditing: item)
            
        } else {
            if let item = templateList?.newTemplate() {
                if let textFieldText = textField.text {
                    item.text = textFieldText
                }
                //item.checked = false
                delegate?.itemDetailViewController(self, didFinishAdding: item)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            addBarButton.isEnabled = true
        }
        navigationItem.largeTitleDisplayMode = .never
        
//        let font = UIFont.boldSystemFont(ofSize: 18)
//        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): font], for: .normal)
//        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): font], for: .normal)
    }
    
    // Show keyboard automatically without tapping textfield
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }

}

extension ItemDetailViewController: UITextFieldDelegate {
    
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
            addBarButton.isEnabled = false
        } else {
            addBarButton.isEnabled = true
        }
        return true
    }
    
}