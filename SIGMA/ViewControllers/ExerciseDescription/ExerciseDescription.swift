//
//  ExerciseDescription.swift
//  SIGMA
//
//  Created by Matt on 5/6/2022.
//

import Foundation

//struct Result: Codable {
//    let data: [ResultItem]
//}

struct ExerciseDesc: Codable {
    let id: Int
    let name: String
    let instructions: String
    let mechanic: String
    let force: String
    let targetmuscle: String
    let utility: String
}
