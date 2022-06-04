//
//  ExerciseCollectionViewCell.swift
//  SIGMA
//
//  Created by Matt on 5/6/2022.
//

import UIKit

class ExerciseCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var exerciseImageView: UIImageView!
    @IBOutlet weak var exerciseNameLabel: UILabel!
    
    let parser = WebService()
    var exercises = [Exercise]()
    
    func setUp(with exercise: Exercise) {
        
        exerciseImageView.image = UIImage.gifImageWithURL(exercise.gifURL)
        exerciseNameLabel.text = exercise.name.capitalized
    }
    
}
