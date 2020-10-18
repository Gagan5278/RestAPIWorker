//
//  JSONArray.swift
//  RestAPIWorker
//
//  Created by Gagan  Vishal on 10/18/20.
//

import Foundation

class JSONArray:  CustomStringConvertible, Sequence {
    
    fileprivate let arrayHolder: [JSONProvider]
    
    //MARK:- Get Count
    public var count: Int {
        return arrayHolder.count
    }
    
    //MARK:- String Convertible
     var description: String {
        return arrayHolder.description
    }
    
    //MARK:- Init
    init(array: [JSON]) {
        self.arrayHolder = array.map{JSONProvider(rawValue: $0)}
    }
    
    //MARK:- Sequecnce Protocol
    func makeIterator() -> some IteratorProtocol {
       return arrayHolder.makeIterator()
    }
    
    subscript(index: Int) -> JSONProvider {
        if arrayHolder.count > index {
            return arrayHolder[index]
        }
        return JSONProvider.Null
    }
    
}
