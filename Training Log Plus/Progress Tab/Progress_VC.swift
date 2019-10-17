//
//  ProgressViewController.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 9/10/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit

class Progress_VC: UIViewController, ProgressDelegate {
    
    var bodyPartData: String?
    var exerciseData: String?
    var startDateData: String?
    var endDateData: String?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    func passDataBack(bodyPart: String, exercise: String, start: String, end: String) {
        
        bodyPartLabel.text = bodyPart
        exerciseLabel.text = exercise
        startDateLabel.text = start
        endDateLabel.text = end
        
        print(bodyPart)
        print(exercise)
        print(start)
        print(end)
    }
    
    
    
    @IBOutlet weak var bodyPartLabel: UILabel!
    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationController?.navigationBar.prefersLargeTitles = true

        // Do any additional setup after loading the view.
    }
    
    // Changes top bar to white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    func selectorDoneButtonPressed(bodyPart: String, exercise: String, start: String, end: String) {
//        bodyPartLabel.text = bodyPart
//        exerciseLabel.text = exercise
//        startDateLabel.text = start
//        endDateLabel.text = end
        
//        print(bodyPart)
//        print(exercise)
//        print(start)
//        print(end)
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

