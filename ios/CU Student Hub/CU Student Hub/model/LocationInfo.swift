//
//  Location.swift
//  CU Student Hub
//
//  Created by Anthony Yang on 5/4/19.
//  Copyright © 2019 Anthony Yang. All rights reserved.
//

import Foundation

struct LocationInfo {
    
    static let mann = Location(name: "Mann Library", imgName: "mann")
    static let olin = Location(name: "Olin Library", imgName: "olin")
    static let math = Location(name: "Math Library", imgName: "math")
    static let uris = Location(name: "Uris Library", imgName: "uris")
    static let law = Location(name: "Law Library", imgName: "law")
    static let hotel = Location(name: "Statler Library", imgName: "hotel")
    static let clark = Location(name: "PSB Clark Library", imgName: "clark")
    static let manage = Location(name: "Management Library", imgName: "manage")
    static let engineering = Location(name: "Engineering Library", imgName: "engineering")
    static let ilr = Location(name: "ILR Library", imgName: "ilr")
    
    static let array: [Location] = [mann, olin, math, uris, law, hotel, clark, manage, engineering, ilr]
    
}
