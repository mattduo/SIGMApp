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
    var exercises: [Exercise]?
    
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
    
    func eventsForDateAndTime(date: Date) -> Event {
        for event in eventsList {
            var components = Calendar.current.dateComponents([.hour], from: event.date!, to: date)
            if components.hour == 0 {
                return event
            }
        }
        return Event()
    }
    
//    func eventsForDateAndTime(date: Date) -> Event {
//        var daysEvents = [Event]()
//        for event in eventsList {
//            if (Calendar.current.isDate(event.date!, equalTo: date, toGranularity: .hour)) {
//                daysEvents.append(event)
//            }
//        }
//        return daysEvents.first!
//    }
}




