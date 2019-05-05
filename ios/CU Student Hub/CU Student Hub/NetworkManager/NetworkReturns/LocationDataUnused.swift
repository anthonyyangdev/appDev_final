//
//  HubData.swift
//  CU Student Hub
//
//  Created by Anthony Yang on 4/26/19.
//  Copyright © 2019 Anthony Yang. All rights reserved.
//

import Foundation

//struct LocationData: Codable {
//
//    var name: String
//    var hours: String
//
//    static func convertLibraryToLocation(with library: LibraryDataResponse) -> [LocationData] {
//
//        let locations = library.locations
//        var locArray: [LocationData] = []
//
//        for loc in locations {
//            let name = loc.name
//            var hours: String
//            let weeks = loc.weeks
//            let date = Date()
//            let calendar = Calendar.current
//            let components = calendar.dateComponents([.weekday, .hour, .minute], from: date)
//            if let weekday = components.weekday {
//                let index = weekday%7
//                let today = weeks[index]
//                switch weekday {
//                case 0:
//                    hours = today.sunday.rendered
//                    break
//                case 1:
//                    hours = today.monday.rendered
//                    break
//                case 2:
//                    hours = today.tuesday.rendered
//                    break
//                case 3:
//                    hours = today.wednesday.rendered
//                    break
//                case 4:
//                    hours = today.thursday.rendered
//                    break
//                case 5:
//                    hours = today.friday.rendered
//                    break
//                case 6:
//                    hours = today.saturday.rendered
//                    break
//                default:
//                    fatalError()
//                }
//                let location = LocationData(name: name, hours: hours)
//                locArray.append(location)
//            } else {
//                fatalError()
//            }
//        }
//        return locArray
//    }
//
//    static func convertEateryToLocation(with eatery: EateryData) -> [LocationData] {
//        let eateries = eatery.data.eateries
//        var locArray: [LocationData] = []
//
//        for e in eateries {
//            let name = e.name
//            let today = e.operatingHours[1].events
//            for event in today {
//                let from = event.startTimestamp
//                let current = Int(Date().timeIntervalSince1970)
//                if current < from {
//                    continue
//                } else {
//                    let start = event.start
//                    let end = event.end
//                    let hours = "\(start) - \(end)"
//                    let location = LocationData(name: name, hours: hours)
//                    locArray.append(location)
//                    break
//                }
//            }
//        }
//
//        return locArray
//    }
//
//
//
//}
