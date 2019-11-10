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
    var passedInExerciseObj: Exercise?
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    var bodyPartPicker = UIPickerView()
    var exercisePicker = UIPickerView()
    var progressionPicker = UIPickerView()
    
    var bodyPartData: [String] = []
    var exerciseData: [Exercise] = []
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
        
        pastAttemptsList = passedInExerciseObj!.attemptList?.allObjects as! [Attempt]
        self.title = passedInExerciseObj?.name
        bodyPartTextField.text = passedInExerciseObj!.bodyPart
        selectedBodyPart = passedInExerciseObj!.bodyPart
        exerciseTextField.text = passedInExerciseObj!.name
        selectedExercise = passedInExerciseObj!.name
        progressionSchemeTextField.text = passedInExerciseObj!.progression
        selectedProgressionScheme = passedInExerciseObj!.progression
        trainingMaxTextField.text = String(passedInExerciseObj!.srtWeight)
        
        bodyPartData = Util.getBodyPartData()
        //exerciseData = Util.getGenericExerciseData()
        progressionSchemeData = Util.getBodybuildingProgressionData()
        
        createPickers()
        createToolbarDoneButton()
        // Do any additional setup after loading the view.
    }
    
    

    
    func addButtonAction() {
        
        passedInExerciseObj?.bodyPart = bodyPartTextField.text!
        passedInExerciseObj?.name = exerciseTextField.text!
        passedInExerciseObj?.progression = progressionSchemeTextField.text!
        passedInExerciseObj?.srtWeight = Int(trainingMaxTextField.text!) ?? 0
        
        if (isItMain!) {
            delegate?.addEditMainExercise_PassTo_workoutDayObjectCreation(self, didFinishEditing: passedInExerciseObj!)
        } else {
            delegate?.addEditAccExercise_PassTo_workoutDayObjectCreation(self, didFinishEditing: passedInExerciseObj!)
        }
        
        appDelegate.saveContext()
        
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
    
    func refreshExerciseList(bp: String) {
        
        let request = Exercise.fetchRequest() as NSFetchRequest<Exercise>
        request.predicate = NSPredicate(format: "bodyPart == '\(bp)'")
        
        do {
            exerciseData = try context.fetch(request)
        } catch let error as NSError {
            print("Could no fetch exerciseData. \(error), \(error.userInfo)")
        }
        
        exercisePicker.reloadAllComponents()
    }

}

extension AddEdit_MainExercise_VC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pastAttemptsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let att = pastAttemptsList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "calcedTrainingMaxes") as! MainExercise_TVCell
        
        if (att.isWendler) {
            let weightForCell = Util.getTMDisplayString(trainingMax: att.trainingMax, weight: att.wenWeight, reps: Double(att.wenReps))
            cell.trainingMaxLabel.attributedText = weightForCell
        } else {
            let sets = att.sets?.allObjects as! [Sets]
            let weightForCell = String(sets[0].weight) + String(sets[0].reps)
            cell.trainingMaxLabel.text = weightForCell
        }
            
            
            
            
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
            returnStr = exerciseData[row].name
        } else if pickerView == progressionPicker {
            returnStr = progressionSchemeData[row]
        }
        
        return returnStr
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == bodyPartPicker {
            selectedBodyPart = bodyPartData[row]
            bodyPartTextField.text = selectedBodyPart
            refreshExerciseList(bp: selectedBodyPart!)
        } else if pickerView == exercisePicker {
            selectedExercise = exerciseData[row].name
            exerciseTextField.text = selectedExercise
        } else if pickerView == progressionPicker {
            selectedProgressionScheme = progressionSchemeData[row]
            progressionSchemeTextField.text = selectedProgressionScheme
        }
    }
}
