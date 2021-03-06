//
//  AddMainExercise_VC.swift
//  Training Log Plus
//
//  Created by Elliott, Josh on 10/24/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit
import CoreData

protocol Pass_MainExerciseObject_BackTo_WorkoutDayCreation_Delegate {
    //func passWorkoutObjBack(workoutObj: WorkoutDay)
    // User hit cancel
    func addEditMainExercise_DidCancel(_ controller: AddEdit_MainExercise_VC)
    // User added item
    func addEditMainExercise_PassTo_workoutDayObjectCreation(_ controller: AddEdit_MainExercise_VC, didFinishAdding item: Exercise)
    // User finishes editing
    func addEditMainExercise_PassTo_workoutDayObjectCreation(_ controller: AddEdit_MainExercise_VC, didFinishEditing item: Exercise)
    
    func addEditAccExercise_PassTo_workoutDayObjectCreation(_ controller: AddEdit_MainExercise_VC, didFinishAdding item: Exercise)
    func addEditAccExercise_PassTo_workoutDayObjectCreation(_ controller: AddEdit_MainExercise_VC, didFinishEditing item: Exercise)
}


class AddEdit_MainExercise_VC: UIViewController {
    
    var delegate: Pass_MainExerciseObject_BackTo_WorkoutDayCreation_Delegate?
    var pastAttemptsList: [Attempt] = []
    var trainingMaxes: [TrainingMax] = []
    var passedInExerciseObj: AnyObject?
    
    var wendlerExercise: Wen_Exercise?
    var bbExercise: BB_Exercise?
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    var bodyPartPicker = UIPickerView()
    var exercisePicker = UIPickerView()
    var progressionPicker = UIPickerView()
    var isWendlerPicker = UIPickerView()
    
    var bodyPartData: [String] = []
    var exerciseData: [Exercise] = []
    var bb_progression: [BB_Progression] = []
    var wen_progression: [Wen_Progression] = []
    var wendlerData: [String] = []
    
    var selectedBodyPart: String?
    var selectedExercise: AnyObject?
    var selectedWenProgression: Wen_Progression?
    var selectedBbProgression: BB_Progression?
    var selectedTrainingMax: String?
    var selectedWendler: String?
    
    var isItMain: Bool?
    
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    @IBOutlet weak var isWendlerTextField: UITextField!
    @IBOutlet weak var bodyPartTextField: UITextField!
    @IBOutlet weak var exerciseTextField: UITextField!
    @IBOutlet weak var progressionSchemeTextField: UITextField!
    @IBOutlet weak var trainingMaxTextField: UITextField!
    @IBOutlet weak var pastTrainingMaxTable: UITableView!
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        addButtonAction()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pastTrainingMaxTable.tableFooterView = UIView(frame: CGRect.zero)
        
        
        if (passedInExerciseObj?.isKind(of: Wen_Exercise.self) ?? false) {
            
            selectedExercise = passedInExerciseObj as! Wen_Exercise
            
            if let tm = selectedExercise?.currentTM {
                trainingMaxTextField.text = String(tm)
            } else {
                trainingMaxTextField.text = ""
            }
            
            //trainingMaxes = selectedExercise?.trainingMaxes??.allObjects as! [TrainingMax]
            trainingMaxes = Array(selectedExercise?.trainingMaxes ?? [])
            
            
            self.title = selectedExercise?.name
            bodyPartTextField.text = selectedExercise?.bodypart
            
            selectedBodyPart = selectedExercise?.bodypart
            exerciseTextField.text = selectedExercise?.name
            progressionSchemeTextField.text = (selectedExercise as! Wen_Exercise).progression?.name
            isWendlerTextField.text = "Yes"
            
            
        } else if (passedInExerciseObj?.isKind(of: BB_Exercise.self) ?? false) {
            
            selectedExercise = passedInExerciseObj as! BB_Exercise
            
            if let sw = selectedExercise?.startingWeight {
                trainingMaxTextField.text = String(sw)
            } else {
                trainingMaxTextField.text = ""
            }
            
            //pastAttemptsList = selectedExercise?.attemptList?.allObjects as! [Attempt]
            
            pastAttemptsList = Array(selectedExercise?.attemptList ?? [])
            
            self.title = selectedExercise?.name
            bodyPartTextField.text = selectedExercise?.bodypart
            
            selectedBodyPart = selectedExercise?.bodypart
            exerciseTextField.text = selectedExercise?.name
            progressionSchemeTextField.text = (selectedExercise as! BB_Exercise).progression?.name
            selectedBbProgression = selectedExercise?.progression
            isWendlerTextField.text = "No"
            
            
        } else {
            self.title = "Choose Exercise"
        }
        
        DataManager.getProgression(exData: &bb_progression)
        DataManager.getProgression(exData: &wen_progression)
        
        
        bodyPartData = Util.getBodyPartData()
        wendlerData = Util.getYesOrNoForPickerData()
        createPickers()
        createToolbarDoneButton()
    }
    
    /*
     * Add Button Action
     */
    func addButtonAction() {
        
        if (selectedExercise as? Wen_Exercise) != nil {
            //let passObj: Wen_Exercise = selectedExercise as! Wen_Exercise
            let passObj = selectedExercise as! Wen_Exercise
            
            passObj.bodypart = bodyPartTextField.text!
            passObj.name = exerciseTextField.text!
            passObj.progression = selectedWenProgression
            passObj.currentTM = Double(trainingMaxTextField.text!)!
            
            if (isItMain!) {
                if (passedInExerciseObj == nil) {
                    delegate?.addEditMainExercise_PassTo_workoutDayObjectCreation(self, didFinishAdding: passObj)
                } else {
                    delegate?.addEditMainExercise_PassTo_workoutDayObjectCreation(self, didFinishEditing: passObj)
                }
            } else {
                if (passedInExerciseObj == nil) {
                    delegate?.addEditAccExercise_PassTo_workoutDayObjectCreation(self, didFinishAdding: passObj)
                } else {
                    delegate?.addEditAccExercise_PassTo_workoutDayObjectCreation(self, didFinishEditing: passObj)
                }
            }
            
        } else if (selectedExercise as? BB_Exercise) != nil {
            let passObj = selectedExercise as! BB_Exercise
            
            passObj.bodypart = bodyPartTextField.text!
            passObj.name = exerciseTextField.text!
            passObj.progression = selectedBbProgression
            passObj.startingWeight = Double(trainingMaxTextField.text!)!
            
            if (isItMain!) {
                if (passedInExerciseObj == nil) {
                    delegate?.addEditMainExercise_PassTo_workoutDayObjectCreation(self, didFinishAdding: passObj)
                } else {
                    delegate?.addEditMainExercise_PassTo_workoutDayObjectCreation(self, didFinishEditing: passObj)
                }
            } else {
                if (passedInExerciseObj == nil) {
                    delegate?.addEditAccExercise_PassTo_workoutDayObjectCreation(self, didFinishAdding: passObj)
                } else {
                    delegate?.addEditAccExercise_PassTo_workoutDayObjectCreation(self, didFinishEditing: passObj)
                }
            }
        }
        
        
        appDelegate.saveContext()
        
        dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
}


/**
 * TABLEVIEW
 */
extension AddEdit_MainExercise_VC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (selectedExercise as? Wen_Exercise) != nil {
            return trainingMaxes.count
        } else {
            return pastAttemptsList.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "calcedTrainingMaxes") as! MainExercise_TVCell
        
        if (selectedExercise as? Wen_Exercise) != nil {
            let tm = trainingMaxes[indexPath.row]
            let weightForCell = Util.getTMDisplayString(trainingMax: tm.getEstTM(), weight: tm.weight, reps: tm.reps)
            //let weightForCell = tm.trainingMax
            cell.trainingMaxLabel.attributedText = weightForCell
            
        } else {
            let att = pastAttemptsList[indexPath.row]
            //let sets = att.sets?.allObjects as! [Sets]
            let sets = Array(att.sets)
            let weightForCell = "Weight: " + String(format: "%.2f", sets[0].weight) + " | Reps: " + String(sets[0].reps)
            cell.trainingMaxLabel.text = weightForCell
        }
        
        return cell
    }
}


/**
 * PICKER
 */
extension AddEdit_MainExercise_VC: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var returnInt = 0
        
        if pickerView == bodyPartPicker {
            returnInt = bodyPartData.count
        } else if pickerView == exercisePicker {
            returnInt = exerciseData.count
        } else if pickerView == progressionPicker {
            returnInt = wen_progression.count
        } else if pickerView == isWendlerPicker {
            returnInt = wendlerData.count
        }
        
        return returnInt
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        var returnStr = ""
        
        if pickerView == bodyPartPicker {
            returnStr = bodyPartData[row]
        } else if pickerView == exercisePicker {
            returnStr = exerciseData[row].name
        } else if pickerView == progressionPicker {
            returnStr = wen_progression[row].name
        } else if pickerView == isWendlerPicker {
            returnStr = wendlerData[row]
        }
        
        return returnStr
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == bodyPartPicker {
            selectedBodyPart = bodyPartData[row]
            bodyPartTextField.text = selectedBodyPart
            

        } else if pickerView == exercisePicker {
            selectedExercise = exerciseData[row]
            exerciseTextField.text = selectedExercise?.name
            
            // Query for progression and fill in progression data
        } else if pickerView == progressionPicker {
            if (selectedWendler?.lowercased() == "yes") {
                selectedWenProgression = wen_progression[row]
                progressionSchemeTextField.text = selectedWenProgression?.name
            } else {
                selectedBbProgression = bb_progression[row]
                progressionSchemeTextField.text = selectedBbProgression?.name
            }
        } else if pickerView == isWendlerPicker {
            selectedWendler = wendlerData[row]
            isWendlerTextField.text = selectedWendler
            
            if selectedWendler?.lowercased() == "yes" {
                DataManager.getWenExercise(exStr: selectedBodyPart!, exData: &exerciseData)
            } else {
                DataManager.getBBExercise(exStr: selectedBodyPart!, exData: &exerciseData)
            }
            
        }
    }
}


/**
 * UTILITY FUNCTIONS
 */
extension AddEdit_MainExercise_VC {
    
    /*
     * Create Pickers
     */
    func createPickers() {
        
        bodyPartPicker.delegate = self
        exercisePicker.delegate = self
        progressionPicker.delegate = self
        isWendlerPicker.delegate = self
        
        
        bodyPartTextField.inputView = bodyPartPicker
        exerciseTextField.inputView = exercisePicker
        progressionSchemeTextField.inputView = progressionPicker
        isWendlerTextField.inputView = isWendlerPicker
    }
    
    /*
     * Create Tool Bar Done Button
     */
    func createToolbarDoneButton() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonAction))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        bodyPartTextField.inputAccessoryView = toolBar
        exerciseTextField.inputAccessoryView = toolBar
        progressionSchemeTextField.inputAccessoryView = toolBar
        trainingMaxTextField.inputAccessoryView = toolBar
        isWendlerTextField.inputAccessoryView = toolBar
    }
    
    
    /*
     * Done Button Action
     */
    @objc func doneButtonAction() {
        if bodyPartTextField.isEditing {
            bodyPartTextField.resignFirstResponder()
            isWendlerTextField.becomeFirstResponder()
        } else if isWendlerTextField.isEditing {
            isWendlerTextField.resignFirstResponder()
            exerciseTextField.becomeFirstResponder()
        } else if exerciseTextField.isEditing {
            exerciseTextField.resignFirstResponder()
            progressionSchemeTextField.becomeFirstResponder()
        } else if progressionSchemeTextField.isEditing {
            progressionSchemeTextField.resignFirstResponder()
            trainingMaxTextField.becomeFirstResponder()
        } else if trainingMaxTextField.isEditing {
            trainingMaxTextField.resignFirstResponder()
            addButtonAction()
        }
    }
}
