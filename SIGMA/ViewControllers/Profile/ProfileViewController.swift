//
//  ProfileViewController.swift
//  SIGMA
//
//  Created by Matt on 26/5/2022.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        logOut()
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    func logOut() {
        do {
            let _ = try Auth.auth().signOut()
        } catch {
            print("error")
        }
    
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
