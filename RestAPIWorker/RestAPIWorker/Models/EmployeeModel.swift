//
//  EmployeeModel.swift
//  RestAPIWorker
//
//  Created by Gagan  Vishal on 10/18/20.
//

import Foundation

struct Employee: Decodable {
    let data: [EmployeeData]
}

struct EmployeeData: Decodable {
    let email: String
}

struct SingleUser: Decodable {
    let data: EmployeeData
}

struct PostModel: Decodable {
    let id: String
}


struct PutModel: Decodable {
    let updatedAt: String
}
