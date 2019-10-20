//
//  AmrapPerformance_ViewController.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 10/19/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit

class AmrapPerformance_VC: UIViewController {

    
    @IBOutlet weak var currentWeight: UILabel!
    @IBOutlet weak var trainingMaxLabel: UILabel!
    
    @IBAction func repsSelector(_ sender: UITextField) {
    }
    
    
    @IBOutlet weak var pastAttemptsTable: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
