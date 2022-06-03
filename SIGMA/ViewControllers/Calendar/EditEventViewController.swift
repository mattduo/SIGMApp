//
//  EditEventViewController.swift
//  SIGMA
//
//  Created by Matt on 18/5/2022.
//

import UIKit

class EditEventViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.date = selectedDate

        // Do any additional setup after loading the view.
    }
    
    @IBAction func dateChanged(_ sender: Any) {
        
        
    }
    
    @IBAction func doneAction(_ sender: Any) {
        let newEvent = Event()
//        newEvent.id = eventsList.count
        newEvent.title = titleTextField.text
        newEvent.date = datePicker.date
        
        eventsList.append(newEvent)
    
        navigationController?.popViewController(animated: true)
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
