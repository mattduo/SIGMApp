//
//  Event.swift
//  SIGMA
//
//  Created by Matt on 4/5/2022.
//

import UIKit
import FirebaseFirestoreSwift
import SwiftUI

var eventsList = [Event]()

class Event: NSObject, Codable {
//    var id: Int!
//    var title: String!
//    var date: Date!
    
    @DocumentID var id: String?
    var title: String?
    var date: Date?
    var notes: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case date
    }
    
    func eventsForDate(date: Date) -> [Event] {
        var daysEvents = [Event]()
        for event in eventsList {
            if (Calendar.current.isDate(event.date!, inSameDayAs: date)) {
                daysEvents.append(event)
            }
        }
        return daysEvents
    }
}




