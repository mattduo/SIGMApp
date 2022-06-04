//
//  LocalJsonParser.swift
//  SIGMA
//
//  Created by Matt on 5/6/2022.
//

import UIKit
import Foundation

class LocalJsonParser {
    
    func parseLocalJson(comp: @escaping ([ExerciseDesc]) -> ()) {
        guard let path = Bundle.main.path(forResource: "exercises", ofType: "json") else {
            return
        }
        let url = URL(fileURLWithPath: path)
        
        do {
            let jsonData = try Data(contentsOf: url)
            let result = try JSONDecoder().decode([ExerciseDesc].self, from: jsonData)
            
            comp(result)
        }
        catch {
            print("Error: \(error)")
        }
    }
}
