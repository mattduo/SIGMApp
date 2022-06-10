//
//  EditEventViewController.swift
//  SIGMA
//
//  Created by Matt on 18/5/2022.
//

import UIKit

class EditEventViewController: UIViewController, AddExerciseDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfExercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let exerciseCell = tableView.dequeueReusableCell(withIdentifier: "addExerciseCell", for: indexPath)
        
        var content = exerciseCell.defaultContentConfiguration()
        let exercise = listOfExercises[indexPath.row]
        content.text = exercise.name
        content.secondaryText = exercise.bodyPart.rawValue
        exerciseCell.contentConfiguration = content
        
        return exerciseCell
    }
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var exerciseTableView: UITableView!
    
    var listOfExercises: [Exercise] = []
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.date = selectedDate

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func dateChanged(_ sender: Any) {
    }
    
    @IBAction func doneAction(_ sender: Any) {
        let newEvent = Event()
        newEvent.title = titleTextField.text
        newEvent.date = datePicker.date
        newEvent.exercises = listOfExercises
        
        eventsList.append(newEvent)
    
        navigationController?.popViewController(animated: true)
    }

    @IBAction func addExercises(_ sender: Any) {
        let addExercisesVC = storyboard?.instantiateViewController(withIdentifier: "addExercisesVC") as! AddExercisesTableViewController
        addExercisesVC.exerciseDelegate = self
        present(addExercisesVC, animated: true)
    }
    
    func addExercise(_ newExercise: Exercise) {
        exerciseTableView.performBatchUpdates({
            listOfExercises.append(newExercise)
            exerciseTableView.insertRows(at: [IndexPath(row: listOfExercises.count - 1, section: 0)], with: .automatic)
            exerciseTableView.reloadData()
        }, completion: nil)
    }
    
}

