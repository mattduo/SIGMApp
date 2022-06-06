//
//  WebService.swift
//  SIGMA
//
//  Created by Matt on 3/6/2022.
//

import UIKit
import Foundation

class WebService {
    
    let MAX_ITEMS_PER_REQUEST = 40
    let MAX_REQUESTS = 10
    var currentRequestIndex = 0
    
    var newExercises = [Exercise]()
    
    
//    func getExercises() {
//        let headers = [
//            "X-RapidAPI-Host": "exercisedb.p.rapidapi.com",
//            "X-RapidAPI-Key": "cb8d8e2757msha265aec0c035261p1eeeafjsnaa24e0ad4e49"
//        ]
//
//        let request = NSMutableURLRequest(url: NSURL(string: "https://exercisedb.p.rapidapi.com/exercises")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
//
//        request.httpMethod = "GET"
//        request.allHTTPHeaderFields = headers
//
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: request as URLRequest) { data, response, error in
//            if let error = error {
//                print(error.localizedDescription)
//            } else {
//                let json = try? JSONSerialization.jsonObject(with: data!, options: [])
//                print("The response: \(json)")
//            }
//        }
//        dataTask.resume()
//    }
//}
        
    func getExercises(comp: @escaping ([Exercise]) -> ()) {
        let headers = [
            "X-RapidAPI-Host": "exercisedb.p.rapidapi.com",
            "X-RapidAPI-Key": "cb8d8e2757msha265aec0c035261p1eeeafjsnaa24e0ad4e49"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://exercisedb.p.rapidapi.com/exercises")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
                do {
                    let result = try JSONDecoder().decode([Exercise].self, from: data!)
                    comp(result)
                } catch {
                    print(error)
                }
            }
        dataTask.resume()
    }
    
    func requestExercisesNamed(_ exerciseName: String) async {
        
        let urlString = "https://exercisedb.p.rapidapi.com/exercises"
        let headers = [
            "X-RapidAPI-Host": "exercisedb.p.rapidapi.com",
            "X-RapidAPI-Key": "cb8d8e2757msha265aec0c035261p1eeeafjsnaa24e0ad4e49"
        ]
        
//        let params = ["bodyPart", "equipment", "gifUrl", "id", "name", "target"]
        
        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = [URLQueryItem(name: "maxResults", value: "\(MAX_ITEMS_PER_REQUEST)"), URLQueryItem(name: "startIndex", value: "\(currentRequestIndex * MAX_ITEMS_PER_REQUEST)"), URLQueryItem(name: "q", value: exerciseName)]
        
        var request = URLRequest(url: (urlComponents?.url)!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
//        for (key, value) in headers {
//            request.setValue(value, forHTTPHeaderField: key)
//        }
        
        do {
            let (data, _) =
            try await URLSession.shared.data(for: request)
            await MainActor.run {
            }
            let decoder = JSONDecoder()
            let exerciseData = try decoder.decode(ExerciseData.self, from: data)
            if let exercises = exerciseData.exercises {
                await MainActor.run {
                newExercises.append(contentsOf: exercises)
                }
                if exercises.count == MAX_ITEMS_PER_REQUEST, currentRequestIndex + 1 < MAX_REQUESTS {
                    currentRequestIndex += 1
                    await requestExercisesNamed(exerciseName)
                }

            }
                
        }
        catch let error {
            print(error)
        }
    }
    
}


