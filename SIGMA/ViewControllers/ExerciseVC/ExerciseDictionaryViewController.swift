//
//  ExerciseDictionaryViewController.swift
//  SIGMA
//
//  Created by Matt on 5/6/2022.
//

import UIKit

class ExerciseDictionaryViewController: UIViewController {
    

    var newExercises = [Exercise]()
    var filteredExercises: [Exercise]!
    let searchController = UISearchController()
            
    @IBOutlet weak var exerciseCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            await getAllExercises()
        }
                
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.searchBar.scopeButtonTitles = ["All", "Upperbody", "Lowerbody", "Cardio"]
        searchController.searchBar.showsScopeBar = true
//        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for Exercises"
        searchController.navigationItem.hidesSearchBarWhenScrolling = false
        
        exerciseCollectionView.dataSource = self
        exerciseCollectionView.delegate = self
        exerciseCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        
    }
    

    
    
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
                self.exerciseCollectionView.reloadData()
            }
        }
        catch let error {
            print(error)
        }
    }
}

extension ExerciseDictionaryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return newExercises.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = exerciseCollectionView.dequeueReusableCell(withReuseIdentifier: "exerciseCell", for: indexPath) as! ExerciseCollectionViewCell
        
        let exercise = newExercises[indexPath.row]
        cell.exerciseNameLabel.text? = exercise.name.capitalized
        cell.exerciseImageView.image = UIImage.gifImageWithURL(exercise.gifURL)

        return cell
    }
}

extension ExerciseDictionaryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 2
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let totalSpace = flowLayout.sectionInset.left + flowLayout.sectionInset.right + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        
        return CGSize(width: size, height: size)
    }
    
}

extension ExerciseDictionaryViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.newExercises.removeAll()
        
        for exercise in self.filteredExercises {
            if exercise.name.lowercased().contains(searchBar.text!.lowercased()) {
                self.newExercises.append(exercise)
            }
        }
        if searchBar.text!.isEmpty {
            self.newExercises = self.filteredExercises
        }
        self.exerciseCollectionView.reloadData()
        
        //        let scopeButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        
//        for exercise in self.filteredExercises {
//            if exercise.name.lowercased().contains(searchBar.text!.lowercased()) {
//                if (exercise.bodyPart.rawValue == "back" || exercise.bodyPart.rawValue == "chest" || exercise.bodyPart.rawValue == "lower arms" || exercise.bodyPart.rawValue == "neck" || exercise.bodyPart.rawValue == "shoulders" || exercise.bodyPart.rawValue == "upper arms") && (scopeButton == "Upperbody") {
//                    self.newExercises.append(exercise)
//                }
//                if (exercise.bodyPart.rawValue == "waist" || exercise.bodyPart.rawValue == "lower legs" || exercise.bodyPart.rawValue == "upper legs") && scopeButton == "Lowerbody" {
//                    self.newExercises.append(exercise)
//                }
//                if (exercise.bodyPart.rawValue == "cardio") && scopeButton == "Cardio" {
//                    self.newExercises.append(exercise)
//                }
//                else {
//                    self.newExercises.append(exercise)
//                }
//            }
//        }


        
//        for exercise in self.filteredExercises {
//            if exercise.name.lowercased().contains(searchBar.text!.lowercased()) {
//                self.newExercises.append(exercise)
//            }
//        }
//        if searchBar.text!.isEmpty {
//            self.newExercises = self.filteredExercises
//        }
//        self.exerciseCollectionView.reloadData()
//    }

    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
        self.newExercises.removeAll()
        
        if selectedScope == 1 {
            for exercise in filteredExercises {
                if (exercise.bodyPart.rawValue == "back" || exercise.bodyPart.rawValue == "chest" || exercise.bodyPart.rawValue == "lower arms" || exercise.bodyPart.rawValue == "neck" || exercise.bodyPart.rawValue == "shoulders" || exercise.bodyPart.rawValue == "upper arms" || exercise.bodyPart.rawValue == "waist") {
                    self.newExercises.append(exercise)
                }
            }
        }
        if selectedScope == 2 {
            for exercise in filteredExercises {
                if (exercise.bodyPart.rawValue == "lower legs" || exercise.bodyPart.rawValue == "upper legs") {
                    self.newExercises.append(exercise)
                }
            }
        }
        if selectedScope == 3 {
            for exercise in filteredExercises {
                if (exercise.bodyPart.rawValue == "cardio") {
                    self.newExercises.append(exercise)
                }
            }
        }
        if selectedScope == 0 {
            self.newExercises = self.filteredExercises
        }
        self.exerciseCollectionView.reloadData()
    }
}
