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

class Event {
    var id: Int!
    var title: String!
    var date: Date!
    
    func eventsForDate(date: Date) -> [Event] {
        var daysEvents = [Event]()
        for event in eventsList {
            if (event.date == date) {
                daysEvents.append(event)
            }
        }
        return daysEvents
    }
}




