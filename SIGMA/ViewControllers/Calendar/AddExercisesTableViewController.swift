//
//  AddExercisesTableViewController.swift
//  SIGMA
//
//  Created by Matt on 9/6/2022.
//

import UIKit

class AddExercisesTableViewController: UITableViewController, UISearchControllerDelegate, UISearchBarDelegate {
    
    var newExercises = [Exercise]()
    var filteredExercises: [Exercise]!
        
    weak var exerciseDelegate: AddExerciseDelegate?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            await getAllExercises()
        }
        
        let search = UISearchController(searchResultsController: nil)
        search.delegate = self
        search.searchBar.delegate = self
        search.navigationItem.searchController = search

    }
    
    // MARK: - WEBSERVICE
    
    func getAllExercises() async {
        
        guard let urlString = URL(string: "https://exercisedb.p.rapidapi.com/exercises") else {
            print ("url error")
            return
        }
        
        let headers = [
            "X-RapidAPI-Host": "exercisedb.p.rapidapi.com",
            "X-RapidAPI-Key": "cb8d8e2757msha265aec0c035261p1eeeafjsnaa24e0ad4e49"
                ]
        
        var request = URLRequest(url: urlString)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            let result = try decoder.decode([Exercise].self, from: data)
            
            
            
            self.newExercises.append(contentsOf: result)
            self.filteredExercises = self.newExercises
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch let error {
            print(error)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newExercises.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath)
        
        
        var content = cell.defaultContentConfiguration()
        let exercise = newExercises[indexPath.row]
        content.text = exercise.name.capitalized
        content.secondaryText = exercise.bodyPart.rawValue.capitalized
        cell.contentConfiguration = content

        return cell
    }
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let exerciseDelegate = exerciseDelegate {
            exerciseDelegate.addExercise(newExercises[indexPath.row])
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
    }

}
