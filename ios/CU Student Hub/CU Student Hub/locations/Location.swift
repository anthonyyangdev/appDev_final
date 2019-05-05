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
    var img: UIImage!
    var isFavorite: Bool
    
    init() {
        self.name = ""
        self.img = UIImage(named: "questions")
        self.isFavorite = false
    }
    
    init(name: String, imgName: String) {
        self.name = name
        self.img = UIImage(named: imgName)
        self.isFavorite = false
    }
    
}
