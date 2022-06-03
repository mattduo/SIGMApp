//
//  FirebaseController.swift
//  SIGMA
//
//  Created by Matt on 31/5/2022.
//

//import UIKit
//import Firebase
//import FirebaseFirestoreSwift
//
//class FirebaseController: NSObject, DatabaseProtocol {
//    
//    func cleanup() {
//        
//    }
//    
//    func addEventToCalendar(listener: DatabaseListener) {
//        
//    }
//    
//    func deleteEventFromCalendar(listener: DatabaseListener) {
//        
//    }
//    
//    var listeners = MulticastDelegate<DatabaseListener>()
//    var eventList: [Event]
//    var userList: [User]
//    
//    var authController: Auth
//    var database: Firestore
//    var eventsRef: CollectionReference?
//    var currentUser: FirebaseAuth.User?
//    
//    override init() {
//        FirebaseApp.configure()
//        authController = Auth.auth()
//        database = Firestore.firestore()
//        eventList = [Event]()
//        
//        super.init()
//    }
//    func addListener(listener: DatabaseListener) {
//        listeners.addDelegate(listener)
//        if listener.listenerType == .calendar {
//            listener.onCalendarChange(change: .update, events: eventList)
//        }
//        if listener.listenerType == .user || listener.listenerType == .auth {
//            listener.onAuthChange(change: .update, users: userList)
//        }
//    }
//    
//    func removeListener(listener: DatabaseListener) {
//        listeners.removeDelegate(listener)
//    }
//    
////    func addEvent(title: String, date: Date, exerciseList: Array<Exercise>, notes: String)
//    
//    
//
//}
