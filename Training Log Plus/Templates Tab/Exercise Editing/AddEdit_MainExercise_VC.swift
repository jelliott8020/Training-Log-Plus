//
//  AddMainExercise_VC.swift
//  Training Log Plus
//
//  Created by Elliott, Josh on 10/24/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit

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
    var passedInExerciseObj: Exercise?
    
    
    var bodyPartPicker = UIPickerView()
    var exercisePicker = UIPickerView()
    var progressionPicker = UIPickerView()
    
    var bodyPartData: [String] = []
    var exerciseData: [String] = []
    var progressionSchemeData: [String] = []
    
    var selectedBodyPart: String?
    var selectedExercise: String?
    var selectedProgressionScheme: String?
    var selectedTrainingMax: String?
    
    var isItMain: Bool?
    
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
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
        //pastAttemptsList = AttemptList()
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pastTrainingMaxTable.tableFooterView = UIView(frame: CGRect.zero)
        
        pastAttemptsList = passedInExerciseObj!.attemptList
        self.title = passedInExerciseObj?.name
        bodyPartTextField.text = passedInExerciseObj!.bodyPart
        exerciseTextField.text = passedInExerciseObj!.name
        progressionSchemeTextField.text = passedInExerciseObj!.progression
        
        bodyPartData = Util.getGenericBodyPartData()
        exerciseData = Util.getGenericExerciseData()
        progressionSchemeData = Util.getGenericProgressionData()
        
        createPickers()
        createToolbarDoneButton()
        // Do any additional setup after loading the view.
    }
    
    

    
    func addButtonAction() {
        
        passedInExerciseObj?.bodyPart = bodyPartTextField.text
        passedInExerciseObj?.name = exerciseTextField.text
        passedInExerciseObj?.progression = progressionSchemeTextField.text
        
        if (isItMain!) {
            delegate?.addEditMainExercise_PassTo_workoutDayObjectCreation(self, didFinishEditing: passedInExerciseObj!)
        } else {
            delegate?.addEditAccExercise_PassTo_workoutDayObjectCreation(self, didFinishEditing: passedInExerciseObj!)
        }
        
        
        dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
     * Create Pickers
     *
     * Creates the pickers for the text fields
     */
    func createPickers() {
        
        bodyPartPicker.delegate = self
        exercisePicker.delegate = self
        progressionPicker.delegate = self
        
        bodyPartTextField.inputView = bodyPartPicker
        exerciseTextField.inputView = exercisePicker
        progressionSchemeTextField.inputView = progressionPicker
    }
    
    /*
     * Create Tool Bar Done Button
     *
     * Creates done buttons for the toolbars
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
    }
    
    
    /*
     * Done Button Action
     *
     * Tells the toolbar what to do when done is tapped
     */
    @objc func doneButtonAction() {
        if bodyPartTextField.isEditing {
            bodyPartTextField.resignFirstResponder()
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

extension AddEdit_MainExercise_VC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pastAttemptsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let weightForCell = pastAttemptsList[indexPath.row].titleForTest
            let cell = tableView.dequeueReusableCell(withIdentifier: "calcedTrainingMaxes") as! MainExercise_TVCell
            
            cell.trainingMaxLabel.text = weightForCell
            
            return cell
    }
}


/*
 * Picker
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
            returnInt = progressionSchemeData.count
        }
        
        return returnInt
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        var returnStr = ""
        
        if pickerView == bodyPartPicker {
            returnStr = bodyPartData[row]
        } else if pickerView == exercisePicker {
            returnStr = exerciseData[row]
        } else if pickerView == progressionPicker {
            returnStr = progressionSchemeData[row]
        }
        
        return returnStr
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == bodyPartPicker {
            selectedBodyPart = bodyPartData[row]
            bodyPartTextField.text = selectedBodyPart
        } else if pickerView == exercisePicker {
            selectedExercise = exerciseData[row]
            exerciseTextField.text = selectedExercise
        } else if pickerView == progressionPicker {
            selectedProgressionScheme = progressionSchemeData[row]
            progressionSchemeTextField.text = selectedProgressionScheme
        }
    }
}
