//
//  JSONProvider.swift
//  RestAPIWorker
//
//  Created by Gagan  Vishal on 10/18/20.
//

import Foundation

typealias JSON = Any

class JSONProvider: ExpressibleByArrayLiteral, ExpressibleByDictionaryLiteral {
    let raw: JSON
    private static let kJSNNull = JSONProvider(rawValue: Void())
    
    //MARK:- Init
    init(rawValue: JSON) {
        raw = rawValue
    }
    
    public init(array: [JSON]) {
        raw = array
    }
    
    public init(dict: [String: JSON]) {
        raw = dict
    }
    
    public required convenience init(arrayLiteral elements: JSON...) {
        self.init(array: elements)
    }
    
    public required convenience init(dictionaryLiteral elements: (String, JSON)...) {
        var jsonDict = [String: JSON]()
        
        for (key, value) in elements {
            jsonDict[key] = value
        }
        self.init(dict: jsonDict)
    }
    
    //MARK:- Get Dict object from if available
    private var dictObject: [String: JSON]? {
        return raw as? [String: JSON]
    }
    
    //MARK: Get Array of available
    private var arrayObject: JSONArray? {
        if let rawArray = raw as? [JSON] {
            return JSONArray(array: rawArray)
        }
        return nil
    }
    
    //MARK:- Get Null
    public static var Null: JSONProvider {
        return kJSNNull
    }

    
    //MARK:- Used if this value represents a JSON object and returns the value associated with the key.
    subscript (key: String) -> JSONProvider {
        guard let dictObject = dictObject else {
            return JSONProvider.Null
        }
        
        guard let rawValue = dictObject[key] else {
            return JSONProvider.Null
        }
        
        return JSONProvider(rawValue: rawValue)
    }
    
    //MARK:- Use if there is an array
    subscript(index: Int) -> JSONProvider {
        return arrayObject?[index] ?? JSONProvider.Null
    }
    
    //MARK:-
    public var string: String? {
        return raw as? String
    }
    
    //MARK:-
    public var int: Int? {
        return raw as? Int
    }
    
    //MARK:-
    public var double: Double? {
        return raw as? Double
    }
    
    //MARK:-
    public var number: NSNumber? {
        return raw as? NSNumber
    }
    
    //MARK:-
    public var bool: Bool? {
        return raw as? Bool
    }
}

//MARK:- Extension
extension JSONProvider {
    convenience init?(fromData data: Data){
        let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        if let dicObject = json as? [String: JSON] {
            self.init(dict: dicObject)
        }
        else if let arrayItems = json as? [JSON] {
            self.init(array: arrayItems)
        }
        else {
            return nil
            
        }
    }
    
    //MARK:- Get Data from raw object
    func makeData() throws -> Data {
        return try JSONSerialization.data(withJSONObject: raw, options: [])
    }
    
    //MARK:- Check if there id no data/body
    func isEmptyData () -> Bool {
        if let void = raw.self as? () {
            print(void)
            if void == () {
                return true
            }
            else {
                return false
            }
        }
        return false

    }
}
