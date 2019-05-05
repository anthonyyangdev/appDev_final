//
//  Message.swift
//  CU Student Hub
//
//  Created by Anthony Yang on 4/22/19.
//  Copyright © 2019 Anthony Yang. All rights reserved.
//

import Foundation
import UIKit

class MessageData {
    
    var message: String
    var author: String
    var image: UIImage   // How to render images from a database
    var isUserAuthor: Bool
    
    init(message: String, author: String, isUserAuthor: Bool) {
        self.message = message
        self.author = author
        self.isUserAuthor = isUserAuthor
        self.image = UIImage()
    }
    
}
