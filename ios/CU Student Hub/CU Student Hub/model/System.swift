//
//  System.swift
//  CU Student Hub
//
//  Created by Anthony Yang on 4/30/19.
//  Copyright © 2019 Anthony Yang. All rights reserved.
//


// Manages the current login state of the user

import Foundation

class System {
    
    static var chats = [Chat]()
    static var currentUser: String?
    static var name: String?
    static var userImage: URL?
    static var profileYear: String?
    static var profileMajor: String?
    static var profileFunFact: String?
    static var favLocation: [Location]?
    static var courseSelected: Course?
    static var userAddedCourses: [String:Course]?
    static var locationSelected: Location?
    
    static func isNew(user: String) -> Bool {
        if currentUser! == user { return false }
        return !chats.contains { chat in chat.friend == user }
    }
    
}
