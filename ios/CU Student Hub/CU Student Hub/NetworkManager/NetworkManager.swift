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
    
    private static let courseAPI = "https://classes.cornell.edu/api/2.0/search/classes.json?roster=SP19&subject="
    private static let messageAPI = ""
    private static let hubAPI = ""
    private static let profileAPI = ""
    private static let locationAPI = ""
    
    static func getClasses(subject: Subject, completion: @escaping ([Course]) -> Void) {
        let apiTarget = courseAPI+"\(subject)"
        Alamofire.request(apiTarget, method: .get).validate().responseData { response in
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
