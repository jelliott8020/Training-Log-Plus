//
//  ChangeTemplateViewController.swift
//  Training Log Plus
//
//  Created by Elliott, Josh on 10/16/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit



class ChangeTemplate_VC: UITableViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func cancel(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    //SelectNewTemplateCell


}
