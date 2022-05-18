//
//  DatabaseProtocol.swift
//  SIGMA
//
//  Created by Matt on 4/5/2022.
//

import Foundation

enum DatabaseChange {
    case auth
    case add
    case remove
    case update
}

enum ListenerType {
    case auth
    case user
    case calendar
}

protocol DatabaseListener: AnyObject {
    var listenerType: ListenerType {get set}
    func onCalendarChange(change: DatabaseChange, events: [Event])
    func onAuthChange(change: DatabaseChange, users: [User])
}

protocol DatabaseProtocol: AnyObject {
    func cleanup()
    func addListener(listener: DatabaseListener)
    func removeListener(listener: DatabaseListener)
    func addEventToCalendar(listener: DatabaseListener)
    func deleteEventFromCalendar(listener: DatabaseListener)
}


