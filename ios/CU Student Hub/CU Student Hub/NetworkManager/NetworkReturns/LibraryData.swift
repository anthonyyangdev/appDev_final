//
//  LocationData.swift
//  CU Student Hub
//
//  Created by Anthony Yang on 4/26/19.
//  Copyright © 2019 Anthony Yang. All rights reserved.
//

import Foundation

struct LocationDataResponse: Codable {
    var data: LibraryLocationData
}

// To parse the JSON, add this file to your project and do:
//
//   let libraryDataResponse = try? newJSONDecoder().decode(LibraryDataResponse.self, from: jsonData)
//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseLibraryDataResponse { response in
//     if let libraryDataResponse = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire


struct LibraryDataResponse: Codable {
    let locations: [LibraryLocationData]
}

struct LibraryLocationData: Codable {
    let name, category: String
    let weeks: [Week]
}

struct Week: Codable {
    let sunday, monday, tuesday, wednesday: Day
    let thursday, friday, saturday: Day
    
    enum CodingKeys: String, CodingKey {
        case sunday = "Sunday"
        case monday = "Monday"
        case tuesday = "Tuesday"
        case wednesday = "Wednesday"
        case thursday = "Thursday"
        case friday = "Friday"
        case saturday = "Saturday"
    }
}

struct Day: Codable {
    let date, rendered: String
}

fileprivate func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

fileprivate func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - Alamofire response handlers

extension DataRequest {
    fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }
            
            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
            
            return Result { try newJSONDecoder().decode(T.self, from: data) }
        }
    }
    
    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseLibraryDataResponse(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<LibraryDataResponse>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}
