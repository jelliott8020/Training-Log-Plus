//
//  ParentWorkoutViewController.swift
//  Training Log Plus
//
//  Created by Elliott, Josh on 10/16/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit

class Workout_VC: UIViewController {

    var currentTemplate: [Template] = []
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var templateLabel: UILabel!
    @IBOutlet weak var tempDayLabel: UILabel!
    
    
    

    
//    @IBAction func beginWorkoutButton(_ sender: UIButton) {
//        print("being")
//    }
//    
//    @IBAction func changeTemplateButton(_ sender: UIButton) {
//        print("change")
//    }
//    
//    @IBAction func skipDayButton(_ sender: UIButton) {
//        print("skip")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataManager.getTemplateCurrent(temp: &currentTemplate)
        
        displayDate()
        displayTemplate()
        displayCurrentDay()

        // Do any additional setup after loading the view.
    }
    
    func displayDate() {
        let dateFormatter = DateFormatter()
        //dateFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .medium
        
        let dateString = dateFormatter.string(from: Date() as Date)
        
        dateLabel.text = String(dateString)
    }
    
    func displayTemplate() {
        if !currentTemplate.isEmpty {
            templateLabel.text = currentTemplate[0].name
        } else {
            templateLabel.text = "No current template selected"
        }
        
        
    }
    
    func displayCurrentDay() {
        tempDayLabel.text = "Current day placeholder"
    }
    
}
