//
//  System.swift
//  CU Student Hub
//
//  Created by Anthony Yang on 4/30/19.
//  Copyright © 2019 Anthony Yang. All rights reserved.
//

import Foundation

class System {
    
    static var chats = [Chat]()
    static var currentUser: String?
    
    static func isNew(user: String) -> Bool {
        if currentUser! == user { return false }
        return !chats.contains { chat in chat.friend == user }
    }
    
}
