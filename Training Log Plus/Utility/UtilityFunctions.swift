//
//  UtilityFunctions.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 10/29/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit

class UtilityFunctions {
    
    /*
     Check for Good Input
     
     Checks the given strings for good input
     If bad, turns border red, shakes them
     If good, returns border to default state
     */
    func checkForBlankInput(str: String, txtField: UITextField) -> Bool {
            if (str == "") {
                shakeAndRedTextField(txtField)
                return true
            } else {
                returnToDefaultTextField(txtField)
                return false
            }
    }
    
    
    /*
     Shake And Red Text Field
     
     Turns the given text field's border red and shakes it
     */
    func shakeAndRedTextField(_ textField: UITextField) {
        let redColor = UIColor.red
        textField.shake()
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = redColor.cgColor
    }
    
    
    /*
     Return to Default Text Field
     
     Changes the text field value back to default
     */
    func returnToDefaultTextField(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 5
    }
    
}
