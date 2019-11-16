//
//  BodyBuildingPerformance_TableViewController.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 10/19/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit

class BodyBuildingPerformance_TVC: UITableViewController {

    
    
    weak var passedInExercise: BB_Exercise?
    var attemptsList: [Attempt] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = passedInExercise?.name
        
        attemptsList = Array(passedInExercise?.attemptList ?? [])
    }

    //bbCell
}

extension BodyBuildingPerformance_TVC {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attemptsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weightForCell = attemptsList[indexPath.row].getAttemptDisplayString()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "bbCell") as! BodyBuildingPerformance_TVCell
        
        cell.cellLabel.attributedText = weightForCell
        
        return cell
    }
    
}
