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
    private static let libraryJSON = "https://api3.libcal.com/api_hours_grid.php?iid=973&lid=0&format=json"
    private static let eateryJSON = "https://now.dining.cornell.edu/api/1.0/dining/eateries.json"

    private static let backendEndpoint = "http://34.73.22.244"
    private static let getAllMessages = "\(backendEndpoint)/api/chats/"
    private static func getCertainUser(netid: String) -> String {
        return "\(backendEndpoint)/api/user/\(netid)/"
    }
    private static func getUserFavoriteLocation(for netid: String) -> String {
        return "\(backendEndpoint)/api/user/\(netid)/locations/"
    }
    private static func postUserFavoriteLocation(for netid: String) -> String {
        return "\(backendEndpoint)/api/user/\(netid)/location/"
    }
    private static func deleteUserFavoriteLocation(at location: String, for netid: String) -> String {
        return "\(backendEndpoint)/api/user/\(netid)/location/\(location)/"
    }
    
    private static let getAllUsers = "\(backendEndpoint)/api/users/"
    private static let createAUser = "\(backendEndpoint)/api/user/"
    private static func getUser(of netid: String) -> String { return "\(backendEndpoint)/api/user/\(netid)/"}
    
    private static let createAndGetChat = "\(backendEndpoint)/api/chats/"
    private static func getPosts(at chatname: String) -> String {
        return "\(backendEndpoint)/api/chat/\(chatname)/posts/"
    }
    private static func post_a_Post(at chatname: String, by netid: String) -> String {
        return "\(backendEndpoint)/api/chat/\(chatname)/post/\(netid)/"
    }
    
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
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
//    static func getLocationData(completion: @escaping ([LocationData]) -> Void) {
//        Alamofire.request(libraryJSON, method: .get).validate().responseData { response in
//            switch response.result {
//            case .success(let data):
//                let jsonDecoder = JSONDecoder()
//                var locations: [LocationData] = []
//                if let libraryResponse = try? jsonDecoder.decode(LibraryDataResponse.self, from: data) {
//                    locations += LocationData.convertLibraryToLocation(with: libraryResponse)
//                    Alamofire.request(eateryJSON, method: .get).validate().responseData(completionHandler: { eateryResponse in
//                        switch response.result{
//                        case .success(let data):
//                            if let eateries = try? jsonDecoder.decode(EateryData.self, from: data) {
//                                locations += LocationData.convertEateryToLocation(with: eateries)
//                                completion(locations)
//                            }
//                            break
//                        case .failure:
//                            completion(locations)
//                        }
//                    })
//                }
//                break
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }

    static func getMessageData(at chatname: String, completion: @escaping ([Post]) -> Void) {
        let params: [String: Any] = ["chatname": chatname]
        Alamofire.request(createAndGetChat, method: .post, parameters: params, encoding: URLEncoding.default, headers: [:]).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let chatResponse = try? jsonDecoder.decode(ChatData.self, from: data) {
                    let posts = chatResponse.data.post
                    completion(posts)
                } else {
                    print("Could not find chats in this response")
                }
                break
            case .failure(let error):
                print("Error")
                print(error.localizedDescription)
            }
        }
    }
    
    // Attempts to make a post request to build a new chat.
    static func postMessage(at chatname: String, text: String, by netid: String, completion: @escaping () -> Void) {
        let params: [String: Any] = ["text": text]
        Alamofire.request(post_a_Post(at: chatname, by: netid), method: .post, parameters: params, encoding: URLEncoding.default, headers: [:]).validate().responseData { response in
            switch response.result {
            case .success(_):
                completion()
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func addFavoriteLocation(at location: String, for netid: String, completion: @escaping () -> Void) {
        let params: [String: Any] = ["location_name": location]
        Alamofire.request(postUserFavoriteLocation(for: netid), method: .post, parameters: params, encoding: URLEncoding.default, headers: [:]).validate().responseData { response in
            switch response.result {
            case .success(_):
                completion()
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    static func deleteFavoriteLocation(at location: String, for netid: String, completion: @escaping () -> Void) {
        Alamofire.request(deleteUserFavoriteLocation(at: location, for: netid), method: .delete).validate().responseData { response in
            switch response.result {
            case .success(_):
                completion()
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    static func getFavoriteLocations(for netid: String, completion: @escaping ([LocationName]) -> Void) {
        Alamofire.request(getUserFavoriteLocation(for: netid), method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let favoriteLocations = try? jsonDecoder.decode(LocationResponse.self, from: data) {
                    completion(favoriteLocations.data)
                }
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    static func addProfile(of name: String, with netid: String, completion: @escaping () -> Void) {
        let params: [String: Any] = ["netid": netid, "name": name]
        Alamofire.request(getUser(of: netid), method: .get).validate().responseData { (response) in
            switch response.result {
            case .success(_):
                // User is not a part of the database yet!!
                Alamofire.request(createAUser, method: .post, parameters: params, encoding: URLEncoding.default, headers: [:]).validate().responseData(completionHandler: { response2 in
                    switch response2.result {
                    case .success(_):
                        // User has been successfully added to the database
                        return
                    case .failure(let error):
                        // User failed to be added to the database
                        print(error.localizedDescription)
                        return
                    }
                })
            case .failure(let error):
                if let status = response.response?.statusCode {
                    if status == 404 {
                        // User already exists
                        return
                    } else {
                        print(error.localizedDescription)
                    }
                } else {
                    print("Bad Error")
                }
            }
        }
    }
    
}
