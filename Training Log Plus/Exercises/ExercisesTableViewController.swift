//
//  ExercisesTableViewController.swift
//  Training Log Plus
//
//  Created by Elliott, Josh on 9/29/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit

class ExercisesTableViewController: UITableViewController {

    
    @IBAction func createButton(_ sender: UIBarButtonItem) {
    }
    
    
    @IBAction func clearButton(_ sender: UIBarButtonItem) {
    }
    
    
    @IBOutlet weak var bodyPartTextField: UITextField!
    @IBOutlet weak var exerciseNameTextField: UITextField!
    @IBOutlet weak var startingWeightTextField: UITextField!
    @IBOutlet weak var maxRepsTextField: UITextField!
    
    
    var bodyPartData: [String] = []
    var maxRepsData: [String] = []
    var startingWeightData: [String] = []
    
    var selectedBodyPart: String?
    var selectedStartingWeight: String?
    var selectedMaxReps: String?
    
    var bodyPartPicker = UIPickerView()
    var startingWeightPicker = UIPickerView()
    var maxRepsPicker = UIPickerView()
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        bodyPartPicker.delegate = self
//        bodyPartPicker.dataSource = self
        
        bodyPartData = getBodyPartData()
        maxRepsData = getMaxRepsData()
        startingWeightData = getStartingWeightData()
        
        createPickers()
        createToolbar()
        
       
    }
    
    func createPickers() {
//            bodyPartPicker = UIPickerView()
//            startingWeightPicker = UIPickerView()
//            maxRepsPicker = UIPickerView()
        
        bodyPartPicker.delegate = self
        startingWeightPicker.delegate = self
        maxRepsPicker.delegate = self
        
        bodyPartTextField.inputView = bodyPartPicker
        bodyPartTextField.inputView = startingWeightPicker
        bodyPartTextField.inputView = maxRepsPicker
    }
    
    func createToolbar() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonAction))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        bodyPartTextField.inputAccessoryView = toolBar
        maxRepsTextField.inputAccessoryView = toolBar
        startingWeightTextField.inputAccessoryView = toolBar
        
        
    }
    
    @objc func doneButtonAction() {
        self.view.endEditing(true)
    }
    
    
    func getBodyPartData() -> [String] {
        return ["Chest", "Back", "Shoulders", "Arms", "Legs", "Abs", "Misc"]
    }
    
    func getMaxRepsData() -> [String] {
        var returnArg: [String] = []
        
        for i in 0...20 {
            returnArg.append(String(i))
        }
        
        return returnArg
    }
    
    func getStartingWeightData() -> [String] {
        var returnArg: [String] = []
        
        for i in 5...500 {
            if i % 5 == 0 {
                returnArg.append(String(i))
            }
        }
        
        return returnArg
    }
    
    
}

extension ExercisesTableViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var returnInt = 0
        
        if pickerView == bodyPartPicker {
            returnInt = bodyPartData.count
        } else if pickerView == maxRepsPicker {
            returnInt = maxRepsData.count
        } else if pickerView == startingWeightPicker {
            returnInt = startingWeightData.count
        }
        
        return returnInt
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        var returnStr = ""
        
        if pickerView == bodyPartPicker {
            returnStr = bodyPartData[row]
        } else if pickerView == maxRepsPicker {
            returnStr = maxRepsData[row]
        } else if pickerView == startingWeightPicker {
            returnStr = startingWeightData[row]
        }
        
        return returnStr
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == bodyPartPicker {
            selectedBodyPart = bodyPartData[row]
            bodyPartTextField.text = selectedBodyPart
        } else if pickerView == maxRepsPicker {
            selectedMaxReps = maxRepsData[row]
            maxRepsTextField.text = selectedMaxReps
        } else if pickerView == startingWeightPicker {
            selectedStartingWeight = startingWeightData[row]
            startingWeightTextField.text = selectedStartingWeight
        }
        
        
    }
    
}
    
    
    
    
    
    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    
    
    
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


