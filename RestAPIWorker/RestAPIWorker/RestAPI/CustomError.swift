//
//  CustomError.swift
//  RestAPIWorker
//
//  Created by Gagan  Vishal on 10/18/20.
//

import Foundation
enum CustomError: Error {
    case invalidURL
    case clientError
    case serviceError
    case errorCustom(Error)
    
    static func mapError(error: Error) -> CustomError {
        return (error as? CustomError) ??  errorCustom(error)
    }
}
