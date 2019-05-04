//
//  CornellCourseData.swift
//  CU Student Hub
//
//  Created by Anthony Yang on 4/26/19.
//  Copyright © 2019 Anthony Yang. All rights reserved.
//

import Foundation
import Alamofire

struct ResponseData: Codable {
     let status: String
     let data: DataClass
}

struct DataClass: Codable {
     let classes: [Course]
}

struct Course: Codable {
     let strm, crseID, crseOfferNbr: Int
     let subject, catalogNbr, titleShort: String
     
     enum CodingKeys: String, CodingKey {
          case strm
          case crseID = "crseId"
          case crseOfferNbr, subject, catalogNbr, titleShort
     }
     
     init() {
          strm = 0
          crseID = 0
          crseOfferNbr = 0
          subject = "CS"
          catalogNbr = "Inf"
          titleShort = "Hecatrice"
     }
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
     func responseCourse(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<Course>) -> Void) -> Self {
          return responseDecodable(queue: queue, completionHandler: completionHandler)
     }
}
