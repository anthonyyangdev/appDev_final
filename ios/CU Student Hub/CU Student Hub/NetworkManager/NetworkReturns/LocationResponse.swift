//
//  LocationResponse.swift
//  CU Student Hub
//
//  Created by Anthony Yang on 5/5/19.
//  Copyright © 2019 Anthony Yang. All rights reserved.
//

import Foundation

struct LocationResponse: Codable {
    
    let success: Bool
    let data: [LocationName]
}

struct LocationName: Codable {
    let location_name: String
}
