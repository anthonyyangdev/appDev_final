//
//  Location.swift
//  CU Student Hub
//
//  Created by Lynie on 5/2/19.
//  Copyright © 2019 Anthony Yang. All rights reserved.
//

import Foundation
import UIKit

class Location{
    
    var name: String
    var type: String
    var img: UIImage!
    var times: String
    var isFavorite: Bool
    
    init() {
        self.name = ""
        self.type = ""
        self.img = UIImage(named: "questions")
        self.times = ""
        self.isFavorite = false
    }
    
    init(name: String) {
        self.name = name
        self.type = ""
        self.img = UIImage(named: "questions")
        self.times = ""
        self.isFavorite = false
    }

}
