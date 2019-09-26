//
//  ViewController.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 9/2/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit

class WorkoutsViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var templateLabel: UILabel!
    @IBOutlet weak var currentDayLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayDate()
        displayTemplate()
        displayCurrentDay()
        
        //navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    @IBAction func beingWorkoutButton(_ sender: UIButton) {
    }
    
    @IBAction func changeTemplateButton(_ sender: UIButton) {
    }
    
    @IBAction func skipDayButton(_ sender: UIButton) {
    }
    
    // Changes top bar to white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
        currentDayLabel.text = "Current day placeholder"
    }
    
//    @IBAction func showAlert() {
//        let alert = UIAlertController(title: "Hello World", message: "This is my first app", preferredStyle: .alert)
//        let action = UIAlertAction(title: "Awesome", style: .default, handler: nil)
//
//        alert.addAction(action)
//        present(alert, animated: true, completion: nil)
//    }


}

