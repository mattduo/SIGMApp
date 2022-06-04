//
//  ExerciseDictionaryViewController.swift
//  SIGMA
//
//  Created by Matt on 5/6/2022.
//

import UIKit

class ExerciseDictionaryViewController: UIViewController {
    
    let parser = WebService()
    var exercises = [Exercise]()
    
    @IBOutlet weak var exerciseCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parser.getExercises {
            data in self.exercises = data
            DispatchQueue.main.async {
                self.exerciseCollectionView.reloadData()
            }
        }
        
        exerciseCollectionView.dataSource = self
        exerciseCollectionView.delegate = self
        exerciseCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
    }
}

extension ExerciseDictionaryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exercises.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = exerciseCollectionView.dequeueReusableCell(withReuseIdentifier: "exerciseCell", for: indexPath) as! ExerciseCollectionViewCell
        
        cell.setUp(with: exercises[indexPath.row])
        
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
}
