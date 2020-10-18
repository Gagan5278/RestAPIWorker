//
//  EndPoint.swift
//  RestAPIWorker
//
//  Created by Gagan  Vishal on 10/18/20.
//

import Foundation

protocol EndPoint {
    var baseURL: String {get}
    var path: String {get}
    var httpMethod: HTTPMethod {get}
    var jsonBody: JSONProvider {get}
    var timeInterval: TimeInterval {get set}
}

extension EndPoint {
    var url : String {
        return self.baseURL + self.path
    }
}
