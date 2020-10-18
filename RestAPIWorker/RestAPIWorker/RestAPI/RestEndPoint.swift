//
//  RestEndPoint.swift
//  RestAPIWorker
//
//  Created by Gagan  Vishal on 10/18/20.
//

import Foundation
enum RestEndPoint: EndPoint {

    case getUserList
    case getUser(id: String)
    case addNewUser(name: String, job: String)
    case updateUser(name: String, job: String)
    case deleteUser
    //Time interval
    fileprivate static var interval: Float = 1.0

    //MARK:- Confirm protocol
    var baseURL: String {
        return "https://reqres.in/"
    }
    
    var path: String {
        switch self {
        case .getUserList:
            return "api/users?page=1"
        case .addNewUser:
            return "api/users"
        case .getUser(let id):
            return "users/\(id)"
        case .updateUser:
            return "api/users/2"
        case .deleteUser:
            return "api/users/2"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getUserList, .getUser(_):
            return .get
        case .addNewUser:
            return .post
        case .updateUser:
            return .put
        case .deleteUser:
           return .delete
        }
    }
    
    var jsonBody: JSONProvider {
        switch self {
        case .getUserList:
            return JSONProvider.Null
        case .addNewUser(let name, let job):
            return JSONProvider.init(dict: ["name": name, "job": job])
        case .getUser(_):
            return JSONProvider.Null
        case .updateUser(let name, let job):
            return JSONProvider.init(dict: ["name": name, "job": job])
        case .deleteUser:
            return JSONProvider.Null
        }
    }

    var timeInterval: TimeInterval {
        get {
            return TimeInterval(RestEndPoint.interval)
        }
        set {
            RestEndPoint.interval = Float(newValue)
        }
    }
    
}


enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}
