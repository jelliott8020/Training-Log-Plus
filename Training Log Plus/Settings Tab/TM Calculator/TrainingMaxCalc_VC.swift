//
//  TrainingMaxCalcViewController.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 10/16/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit

class TrainingMaxCalc_VC: UIViewController {
    
    @IBOutlet weak var calcedTable: UITableView!
    @IBOutlet weak var repsTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    
    //var weightPicker = UIPickerView()
    //var repsPicker = UIPickerView()
    
    var weightData: [Int] = []
    var repsData: [Int] = []
    var calcedWeightsArray: [Int] = []
    var calcedWeightsArrayText: [String] = []
    var calcedArrayObj: [TMCell] = []
    
    var selectedWeight: Int?
    var selectedReps: Int?
    
    
    @IBAction func calculateButton(_ sender: UIButton) {
        insertNewCalc()
    }
    
    
    // create struct with weight, reps, tm, and string
    // append struct to array
    // sort array by tm
    
    func insertNewCalc() {
        let reps = repsTextField.text
        let weight = weightTextField.text
        
        if (reps != "" && weight != "") {
            let weightNum: Double? = Double(weight!)
            let repsNum: Double? = Double(reps!)
            
            let calcedWeight = weightNum! * repsNum! * 0.0333 + weightNum!
            let roundedWeight = rounder(calcedWeight, toNearest: 5)
            
            calcedWeightsArray.append(Int(roundedWeight))
            calcedWeightsArrayText.append("Weight: " + weight! + " Reps: " + reps! + " TM: " + String(format: "%.0f", roundedWeight))
            
            let tm = TMCell(reps: repsNum!, weight: weightNum!)
            calcedArrayObj.append(tm)
            //calcedArrayObj.sort(by: sorterForFileIDASC)
            
            
            //print(roundedWeight)
            
            let indexPath = IndexPath(row: calcedArrayObj.count - 1, section: 0)
            
            calcedTable.beginUpdates()
            calcedTable.insertRows(at: [indexPath], with: .automatic)
            calcedTable.endUpdates()
            
            filterList()
            
            weightTextField.text = ""
            repsTextField.text = ""
            view.endEditing(true)
        }
    }
    
    func filterList() {
        calcedArrayObj = calcedArrayObj.sorted() { $0.tm > $1.tm }
        calcedTable.reloadData();
    }
    
    func sorterForFileIDASC(this:TMCell, that:TMCell) -> Bool {
      return this.tm > that.tm
    }
    
    func rounder(_ value: Double, toNearest: Double) -> Double {
        return round(value / toNearest) * toNearest
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calcedTable.tableFooterView = UIView(frame: CGRect.zero)
        
        weightData = getWeightData()
        repsData = getRepsData()
        
        //createPickers()
        createToolbarDoneButton()

        // Do any additional setup after loading the view.
    }
    
    
//    func createPickers() {
//        weightPicker.delegate = self
//        repsPicker.delegate = self
//
//        repsTextField.inputView = repsPicker
//        weightTextField.inputView = weightPicker
//    }
    
    func createToolbarDoneButton() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonAction))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        weightTextField.inputAccessoryView = toolBar
        repsTextField.inputAccessoryView = toolBar
    }
    
    @objc func doneButtonAction() {
        self.view.endEditing(true)
    }
    
    func getWeightData() -> [Int] {
        var returnArg: [Int] = []
        
        for i in 0...500 {
            if i % 5 == 0 {
                returnArg.append(i)
            }
        }
        
        return returnArg
    }
    
    func getRepsData() -> [Int] {
        var returnArg: [Int] = []
        
        for i in 0...30 {
            returnArg.append(i)
        }
        
        return returnArg
    }

}

//extension TrainingMaxCalc_VC: UIPickerViewDataSource, UIPickerViewDelegate {
//    
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//        
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        var returnInt = 0
//        
//        if pickerView == weightPicker {
//            returnInt = weightData.count
//        } else if pickerView == repsPicker {
//            returnInt = repsData.count
//        }
//        
//        return returnInt
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        
//        var returnStr = ""
//        
//        if pickerView == weightPicker {
//            returnStr = String(weightData[row])
//        } else if pickerView == repsPicker {
//            returnStr = String(repsData[row])
//        }
//        
//        return returnStr
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if pickerView == weightPicker {
//            selectedWeight = weightData[row]
//            weightTextField.text = String(selectedWeight!)
//        } else if pickerView == repsPicker {
//            selectedReps = repsData[row]
//            repsTextField.text = String(selectedReps!)
//        }
//    }
//}

extension TrainingMaxCalc_VC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calcedArrayObj.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weightForCell = calcedArrayObj[indexPath.row].displayString
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalcedCell") as! Calced_TVCell
        cell.calcedLabel.text = weightForCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            calcedArrayObj.remove(at: indexPath.row)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    

}
