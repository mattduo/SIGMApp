//
//  OneRepMaxCalculatorUIViewController.swift
//  SIGMA
//
//  Created by Matt on 26/5/2022.
//

import UIKit

class OneRepMaxCalculatorUIViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var genderPicker: UIPickerView!
    
    @IBOutlet weak var exerciseTextField: UITextField!
    @IBOutlet weak var exercisePicker: UIPickerView!
    
    @IBOutlet weak var exerciseWeightTextField: UITextField!
    @IBOutlet weak var repetitionsTextField: UITextField!
    @IBOutlet weak var bodyweightTextField: UITextField!
    
    var exercise = ["Barbell Squat", "Bench Press", "Deadlift (Sumo Or Conventional)"]
    var gender = ["Male", "Female"]

    override func viewDidLoad() {
        genderPicker.isHidden = true
        exercisePicker.isHidden = true
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == genderPicker {
            return gender.count
        }
        return exercise.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
        if pickerView == genderPicker {
            return gender[row]
        }
        return exercise[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == genderPicker {
            self.genderTextField.text = gender[row]
            self.genderPicker.isHidden = true
        }
        self.exerciseTextField.text = exercise[row]
        self.exercisePicker.isHidden = true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == genderTextField {
            self.genderPicker.isHidden = false
            genderTextField.endEditing(true)
        }
        self.exercisePicker.isHidden = false
        exerciseTextField.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    @IBAction func calculateORMButton(_ sender: Any) {
        guard let weight = Double(exerciseWeightTextField.text!) else { return }
        guard let reps = Double(repetitionsTextField.text!) else { return }
        let estimatedORM = Double((100 * weight) / (48.8+53.8*exp(-0.075*reps)))
        
        let estimatedORMDouble = String(format: "%.0f", estimatedORM)
        
        displayMessage(title: "Estimated One-Rep-Max Calculated!", message: "Your Estimated One-Rep-Max for \(exerciseTextField.text!) is \(estimatedORMDouble) kg!" )
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
