//
//  LogInViewController.swift
//  SIGMA
//
//  Created by Matt on 3/5/2022.
//

import UIKit

class LogInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBAction func loginButtonTapped(_ sender: Any) {
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
