//
//  Event.swift
//  SIGMA
//
//  Created by Matt on 4/5/2022.
//

import UIKit
import FirebaseFirestoreSwift
import SwiftUI

class Event: NSObject, Codable {
    @DocumentID var id: String?
    var notes: String?
//    var exercises: Array<Any>?
    var title: String?
//    var photos: Image
}

enum CodingKeys: String, CodingKey {
    case id
    case notes
    case title
}




