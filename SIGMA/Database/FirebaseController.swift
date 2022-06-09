//
//  FirebaseController.swift
//  SIGMA
//
//  Created by Matt on 31/5/2022.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class FirebaseController: NSObject, DatabaseProtocol {
    
    func cleanup() {
        
    }
    
    func addEventToCalendar(listener: DatabaseListener) {
        
    }
    
    func deleteEventFromCalendar(listener: DatabaseListener) {
        
    }
    var user: User?
    var listeners = MulticastDelegate<DatabaseListener>()
    var eventList: [Event]
//    var userList: [User]
    
    var authController: Auth
    var database: Firestore
    var eventsRef: CollectionReference?
    var currentFirebaseUser: FirebaseAuth.User?
    var currentUser: User?
    var usersRef: CollectionReference?
    
    override init() {
        FirebaseApp.configure()
        authController = Auth.auth()
        database = Firestore.firestore()
        eventList = [Event]()
        
        super.init()
    }
    func addListener(listener: DatabaseListener) {
        listeners.addDelegate(listener)
        if listener.listenerType == .calendar {
            listener.onCalendarChange(change: .update, events: eventList)
        }
//        if listener.listenerType == .user || listener.listenerType == .all {
//            listener.onAuthChange(change: .update, users: userList)
//        }
    }
    
    func removeListener(listener: DatabaseListener) {
        listeners.removeDelegate(listener)
    }
    
//    func addEvent(title: String, date: Date, exerciseList: Array<Exercise>, notes: String)
    
    func setupUserListener() {
        guard let currentFirebaseUser = currentFirebaseUser else {
            return
        }

        usersRef = database.collection("users")
        usersRef?.whereField("email", isEqualTo: "\(currentFirebaseUser.email!)").addSnapshotListener{ (querySnapshot, error) in
            guard let querySnapshot = querySnapshot, let userSnapshot = querySnapshot.documents.first else {
                return
            }
            
            self.parseUserSnapshot(snapshot: userSnapshot)
        }
    }
    
    func parseUserSnapshot(snapshot: QueryDocumentSnapshot) {
        let user = User()
        user.id = snapshot.documentID
        user.email = snapshot.data()["email"] as? String
        user.preferredUnitOfMeasurement = snapshot.data()["preferredUnitOfMeasurement"] as? Bool
//        user.events = []
//      do code for events
        currentUser = user
    }
    
    func addUser(email: String, preferredUnit: Bool) -> User {
        let user = User()
        user.email = email
        user.preferredUnitOfMeasurement = preferredUnit
        user.events = []
        
        do {
            usersRef = database.collection("users")
            if let newUser = try usersRef?.addDocument(from: user) {
                user.id = newUser.documentID
            }
        } catch {
            print("user cannot be serialised")
        }
        return user
    }
    
    func setupEventsListener() {
        eventsRef = usersRef?.document("\(currentUser!.id!)").collection("events")
    }
}
