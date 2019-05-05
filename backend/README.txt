This is the Backend portion of the project
https://paper.dropbox.com/doc/CU-Student-Hub-Backend-iOS-Handoff-Doc--AccKbUDLXdBjvIYKmPhvB1cKAQ-w7Dnd1sB946MEcKfstQ8M


CU Student Hub Backend-iOS Handoff Doc

Expected Functionality

Note for iOS: Notice that there are multiple Swift classes/structs you would need to make: `User`, `Location`, `Chats`, `Posts`. This is a guide for Backend as to how they should write up the specs for iOS, and is a guide for iOS for how to decipher the specs and translate it to networking code.

Get all users

Request: `GET /api/``user``s``/`
Response:

    {
      "success": True,
      "data": [
        {
          "netid": ym284,
          "name": "Yaoyao Ma"
        },
        {
          "netid": yz476,
          "name": "Yihan Zhang"
        }
      ]
    }

Example iOS Response model: 
(Note for Backend: you don’t need to make these for iOS, the following is a guide for iOS)

    struct Class {
      var id: Int,
      var code: String,
      var name: String,
      var assignments: [Assignment],
      var students: [Student],
      var instructors: [Instructor]
      // or, if students and instructors are both Users, make them [User], up to you
    }
    
    struct ClassesResponse {
      var success: Bool
      var data: [Class]
    }

Example iOS Alamofire request:

    static func getClasses(completion: @escaping ([Class]) -> Void) {
      let endpoint = "\(endpointVariable)/api/classes/"
      Alamofire.request(endpoint, method: .get).validate().responseData { response in
        switch response.result {
        case .success(let data):
            let jsonDecoder = JSONDecoder()
            if let classesResponse = try? jsonDecoder.decode(ClassesResponse.self, from: data) {
                completion(classesResponse.data)
            } else {
                print("Invalid Response Data")
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
      }
    }
Create a user

Request: `POST /api/``user``/`
Body:

    {
      "netid": <USER INPUT>,
      "name": <USER INPUT>
    }

Response:

    {
      "success": True,
      "data": {
        "netid": <USER INPUT FOR NETID>,
        "name": <USER INPUT FOR NAME>
      }
    }

Example iOS Response model:

    struct PostResponse {
      var success: Bool
      // Note: you don't need data here because you're POST-ing, not getting data back. 
      // You can choose whether or not you want to have the data variable here.
      // You need the "success" variable here because you want to know if you successfully
      // sent the information to the backend.
    }

Example iOS Alamofire request:

    static func createClass(code: String, name: String, completion: @escaping (Bool) -> Void) {
      let postEndpoint = "\(endpointVariable)/api/classes/"
      let parameters: [String: Any] = [
                      "code": code,
                      "name": name
      ]
      Alamofire.request(postEndpoint, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: [:]).validate().responseData { response in
          switch response.result {
          case .success(let data):
              let jsonDecoder = JSONDecoder()
              if let postResponse = try? jsonDecoder.decode(PostResponse.self, from: data) {
                  completion(postResponse.success)
              } else {
                  print("Invalid Response Data")
              }
          case .failure(let error):
              print(error.localizedDescription)
        }
      }
    }
Get a specific user

Request: `GET /api/``class``/<path:netid>/`
Response:

    {
      "success": True,
      "data": <USER WITH NETID {netid}>
    } 

Example iOS Response model:

    struct ClassResponse {
      var success: Bool
      var data: Class
    }

Example iOS Alamofire request:

    static func getClass(with id: Int, completion: @escaping (Class) -> Void) {
      let endpoint = "\(endpointVariable)/api/class/\(id)/"
      Alamofire.request(endpoint, method: .get).validate().responseData { response in
        switch response.result {
        case .success(let data):
            let jsonDecoder = JSONDecoder()
            if let classResponse = try? jsonDecoder.decode(ClassResponse.self, from: data) {
                completion(classResponse.data)
            } else {
                print("Invalid Response Data")
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
      }
    }



Add a class for a user

Request: `POST /`api/user/<path:netid>/add/
Body:

    {
      "class_name": <USER INPUT>,
      "class_code": <USER INPUT>
    }

Response:

    {
      "success": True,
      "data": {
        "name": <USER INPUT FOR NAME>,
        "code": <USER INPUT FOR CODE>
      }
    }



Delete a class of a user

Request: `DELETE` `/`api/user/<path:netid>/delete/<int:code>/
Response:

    {
      "success": True,
      "data": <DELETED CLASS>
    }
Delete a user

Request: `DELETE` `/api/``user``/<path:netid>``/`
Response:

    {
      "success": True,
      "data": <DELETED USER>
    }


Get a user’s favorite locations

Request: `GET /api/``class``/<path:netid>/``locations/`
Response:

    {
      "success": True,
      "data": <LOCATIONS WITH NETID {netid}>
    } 


Add a favorite location for a user

Request: `POST /api/``user``/<path:netid>/location/`
Body:

    {
      "location_name": <USER INPUT>
    }

Response:

    {
      "success": True,
      "data": {
        "location_name": <USER INPUT FOR LOCATION_NAME>
      }
    }



Delete a favorite location for a user

Request: `DELETE` `/api/user/<path:netid>/location/<string:location_name>/`
Response:

    {
      "success": True,
      "data": <DELETED USER>
    }



Get all chats

Request: `GET /api/``chats``/`
Response:

    {
      "success": True,
      "data": [
        {
          "chatname": "CS 1110-Olin Library",
          "post": "Hey you!"
        },
        {
          "netid": "CS 2110-Uris Library",
          "post": "Hi there!"
        }
      ]
    }



Create a chat

Request: `POST /api/``chats``/`
Body:

    {
      "chat_name": <USER INPUT>
    }

Response:

    {
      "success": True,
      "data": {
        "chat_name": <USER INPUT FOR CHAT_NAME>,
        "post": []
      }
    }



Get a specific chat

Request: `GET /api/chat/<string:chatname>/`
Response:

    {
      "success": True,
      "data": <CHAT WITH CHAT_NAME {chatname}>
    } 



Get a chat’s posts

Request: `GET /api/chat/<string:chat_name>/posts/`
Response:

    {
      "success": True,
      "data": <POSTS WITH CHAT_NAME {chat_name}>
    } 



Create a post in a chat

Request: `POST /api/chat/<string:chat_name>/post/<string:netid>/`
Body:

    {
      "text": <USER INPUT>
    }

Response:

    {
      "success": True,
      "data": {
        "text": <USER INPUT FOR TEXT>,
        "username": <USER INPUT FOR USERNAME>,
        "chatname": <USER INPUT FOR CHATNAME>,
      }
    }

