//
//  ParentWorkoutViewController.swift
//  Training Log Plus
//
//  Created by Elliott, Josh on 10/16/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit

class Workout_VC: UIViewController {

    
    
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
//    
//    @IBAction func customWorkoutButton(_ sender: UIButton) {
//        print("custom")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        templateLabel.text = "Template placeholder"
    }
    
    func displayCurrentDay() {
        tempDayLabel.text = "Current day placeholder"
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
