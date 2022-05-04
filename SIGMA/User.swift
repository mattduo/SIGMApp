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
    var name: String?
    var Users: [User] = []

}
