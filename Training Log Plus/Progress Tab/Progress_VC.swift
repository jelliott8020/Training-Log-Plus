//
//  ProgressViewController.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 9/10/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit

class Progress_VC: UIViewController, PassDataBackProtocol {
    
    var bodyPartData: String?
    var exerciseData: String?
    var startDateData: String?
    var endDateData: String?
    
    @IBOutlet weak var bodyPartLabel: UILabel!
    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func passDataBack(bodyPart: String, exercise: String, start: String, end: String) {
        
        bodyPartLabel.text = bodyPart
        exerciseLabel.text = exercise
        startDateLabel.text = start
        endDateLabel.text = end
        
        self.bodyPartData = bodyPart
        self.exerciseData = exercise
        self.startDateData = start
        self.endDateData = end
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "exerciseSelectSegue" {
            
            let secondVC = segue.destination as! SelectProgressExercises_VC
            
            // Do this if you want to pass data forward
            //secondVC.data = textField1.text!
            
            secondVC.delegate = self
        }
    }
}

