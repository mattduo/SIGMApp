//
//  LogInViewController.swift
//  SIGMA
//
//  Created by Matt on 3/5/2022.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
       }
        if email.isEmpty || password.isEmpty {
            var errorMsg = "Please ensure all fields are filled:\n"
            if email.isEmpty {
                errorMsg += "- Must provide an email\n"
            }
            if password.isEmpty {
                errorMsg += "- Must provide a password"
            }
            displayMessage(title: "Not all fields filled", message: errorMsg)
            return
       }
        signIn(email: email, password: password)
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            guard let authResult = authResult?.user, error == nil else {
                self.displayMessage(title: "Error", message: error!.localizedDescription)
                return
            }
            self.performSegue(withIdentifier: "loggedInSegue", sender: self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLabel.alpha = 0 // Hiding error label

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
