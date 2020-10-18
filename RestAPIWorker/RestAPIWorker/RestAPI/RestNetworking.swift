//
//  RestNetworking.swift
//  RestAPIWorker
//
//  Created by Gagan  Vishal on 10/18/20.
//

import Foundation
import Combine

fileprivate protocol Network {
     func createRequest(from endPoint: EndPoint) -> URLRequest
    func callService<T: Decodable>(at endPoint: EndPoint, model: T.Type, decoder: JSONDecoder) -> AnyPublisher<T?, CustomError>
}

class RestNetworking: Network {
    //MARK:- Create Request
     func createRequest(from endPoint: EndPoint) -> URLRequest {
        var request = URLRequest(url: URL(string: endPoint.url)!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: endPoint.timeInterval)
        //1.Method
        request.httpMethod = endPoint.httpMethod.rawValue
        //2.Boby
        if !endPoint.jsonBody.isEmptyData() {
            do {
                request.httpBody = try endPoint.jsonBody.makeData()
            }
            catch {
                print(error)
            }
        }
        //3.Time Interval
        request.timeoutInterval = endPoint.timeInterval
        return request
    }
    
    //MARK:- Call Service
    func callService<T>(at endPoint: EndPoint, model: T.Type, decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<T?, CustomError> where T : Decodable {
        guard let _ = URL(string: endPoint.url) else {
            return Fail(error: CustomError.invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: self.createRequest(from: endPoint))
            .tryMap { response -> Data in
                guard let httpURLResponse = response.response as? HTTPURLResponse, 200..<299 ~= httpURLResponse.statusCode  else {
                    throw CustomError.serviceError
                }
                return response.data
            }
            .flatMap{ data -> AnyPublisher<T?, Error> in
                if data.isEmpty {
                    return Just((true as? T) ?? nil).setFailureType(to: Error.self).eraseToAnyPublisher()
                }
                return Just(data).decode(type: T?.self, decoder: decoder)
                    .eraseToAnyPublisher()
            }
            .mapError{CustomError.mapError(error: $0)}
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        
    }
    
}
