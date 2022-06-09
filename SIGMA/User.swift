//
//  User.swift
//  SIGMA
//
//  Created by Matt on 4/5/2022.
//

import UIKit
import FirebaseFirestoreSwift

class User: NSObject, Codable {
    
    @DocumentID var id: String?
    var events: [Event] = []
    var email: String?
    var preferredUnitOfMeasurement: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, email, preferredUnitOfMeasurement
    }
    
}

