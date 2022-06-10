//
//  LogInViewController.swift
//  SIGMA
//
//  Created by Matt on 3/5/2022.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {
    
    weak var databaseController: DatabaseProtocol?
    
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
    
    //signIn function
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            guard let authResult = authResult?.user, error == nil else {
                self.displayMessage(title: "Error", message: error!.localizedDescription)
                return
            }
            self.databaseController?.currentFirebaseUser = authResult
            self.databaseController?.setupUserListener()
            self.performSegue(withIdentifier: "loggedInSegue", sender: self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLabel.alpha = 0 // Hiding error label
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        databaseController = appDelegate?.databaseController
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "dumbells")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        navigationItem.hidesBackButton = false


    }

}
