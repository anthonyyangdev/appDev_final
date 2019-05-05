// To parse the JSON, add this file to your project and do:
//
//   let eateryData = try? newJSONDecoder().decode(EateryData.self, from: jsonData)
//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseEateryData { response in
//     if let eateryData = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

struct EateryData: Codable {
    let data: EateryDataClass
}

struct EateryDataClass: Codable {
    let eateries: [Eatery]
}

struct Eatery: Codable {
    let name: String
    let operatingHours: [OperatingHour]
}

struct OperatingHour: Codable {
    let date, status: String
    let events: [Event]
}

struct Event: Codable {
    let startTimestamp, endTimestamp: Int
    let start, end: String
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
    func responseEateryData(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<EateryData>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}
