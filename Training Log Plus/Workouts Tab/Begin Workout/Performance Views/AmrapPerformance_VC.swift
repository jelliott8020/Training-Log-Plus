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
    @IBOutlet weak var repsTextField: UITextField!
    @IBOutlet weak var pastAttemptsTable: UITableView!
    
    
    weak var passedInExercise: Wen_Exercise?
    var personalRecords: [PersonalRecord] = []
    var passedInWeight: Double?
    
    //weak var passedInExercise: BB_Exercise?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = passedInExercise?.name
        
        pastAttemptsTable.tableFooterView = UIView(frame: CGRect.zero)
        
        personalRecords = Array(passedInExercise?.personalRecords ?? [])
        
        currentWeight.text = String(passedInWeight!)
    }

    

}

extension AmrapPerformance_VC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personalRecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weightForCell = personalRecords[indexPath.row].getPrDisplayString()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "amrapCell") as! AmrapPerformance_TVCell
        
        cell.cellLabel.attributedText = weightForCell
        
        return cell
    }
    
    
    
    
}
