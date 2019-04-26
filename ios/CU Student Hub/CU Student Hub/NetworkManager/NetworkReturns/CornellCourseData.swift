//
//  CornellCourseData.swift
//  CU Student Hub
//
//  Created by Anthony Yang on 4/26/19.
//  Copyright © 2019 Anthony Yang. All rights reserved.
//

import Foundation

struct CornellCourseDataResponse: Codable {
    var data: CornellCourseData
}

struct CornellCourseData : Codable {
    var rosters: [CornellRosterData]
}

struct CornellRosterData: Codable {
    var descr: String
    var strm: String
    var defaultLocation: String
    var defaultSessionCode: String
    var defaultCampus: String
    var version: CornellRosterVersionData
}

struct CornellRosterVersionData: Codable {
    var status: String
}
