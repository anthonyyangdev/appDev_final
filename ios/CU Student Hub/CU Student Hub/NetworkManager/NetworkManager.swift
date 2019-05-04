//
//  NetworkManager.swift
//  CU Student Hub
//
//  Created by Anthony Yang on 4/26/19.
//  Copyright © 2019 Anthony Yang. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    private static let courseAPI = "https://classes.cornell.edu/api/2.0/search/classes.json?roster=FA19&subject=CS"
    private static let messageAPI = ""
    private static let hubAPI = ""
    private static let profileAPI = ""
    private static let locationAPI = ""
    
//    static func getCourses(completion: @escaping ([CornellRosterData]) -> Void) {
//        Alamofire.request(cornellCourseAPI, method: .get).responseData { response in
//            switch response.result {
//            case .success(let data):
//                let decode = JSONDecoder()
//                if let courseResponse = try? decode.decode(CornellCourseDataResponse.self, from: data) {
//                    let classes = courseResponse.data.rosters
//                    completion(classes)
//                } else {
//                    print("Something went wrong while connecting to the servers.")
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
    
    static func getClasses(completion: @escaping ([Course]) -> Void) {
        Alamofire.request(courseAPI, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let courseResponse = try? jsonDecoder.decode(ResponseData.self, from: data){
                    let classes = courseResponse.data.classes
                    completion(classes)
                }
                else {
                    print("Invalid response data")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getMessageData(completion: @escaping ([MessageData]) -> Void) {
        // TODO : Implement me
    }
    
    static func getHubContents(completion: @escaping ([HubData]) -> Void) {
        // TODO : Implement me
    }
    
    static func getProfileInfo(completion: @escaping ([UserProfileData]) -> Void) {
        // TODO : Implement me
    }
    
    static func getLocationData(completion: @escaping ([UserProfileData]) -> Void) {
        // TODO : Implement me
    }
    
}
