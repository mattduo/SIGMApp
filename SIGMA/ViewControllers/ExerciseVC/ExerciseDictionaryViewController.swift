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

    let parser = WebService()
    var exercises = [Exercise]()
    let webService = WebService()
    
    let sbv = SearchBarView()
    
    @IBOutlet weak var exerciseCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            await getAllExercises()
        }
                
        
        
        exerciseCollectionView.dataSource = self
        exerciseCollectionView.delegate = self
        exerciseCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        sbv.setUpSearchBar()
        
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

extension ExerciseDictionaryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //to-do
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let searchView: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "searchBar", for: indexPath)

        
        return searchView
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80)
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
    }
}
