//
//  WebService.swift
//  SIGMA
//
//  Created by Matt on 3/6/2022.
//

import UIKit
import Foundation

class WebService {
    
    func getExercises() {
        let headers = [
            "X-RapidAPI-Host": "exercisedb.p.rapidapi.com",
            "X-RapidAPI-Key": "cb8d8e2757msha265aec0c035261p1eeeafjsnaa24e0ad4e49"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://exercisedb.p.rapidapi.com/exercises")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                let json = try? JSONSerialization.jsonObject(with: data!, options: [])
                print("The response: \(json)")
            }
        }
        dataTask.resume()
    }
}
