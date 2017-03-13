//
//  JSONDecodable.swift
//  ComicList
//
//  Created by Eric Risco de la Torre on 11/03/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation

public func decode<T: JSONDecodable>(jsonDictionary: JSONDictionary) throws -> T {
    return try T(jsonDictionary: jsonDictionary)
}

public func decode<T: JSONDecodable>(jsonArray: JSONArray) throws -> [T] {
    return try jsonArray.map { try decode(jsonDictionary: $0) }
}

public func decode<T: JSONDecodable>(data: Data) throws -> T {
    
    let object = try JSONSerialization.jsonObject(with: data, options: [])
    
    guard let dict = object as? JSONDictionary else {
        throw JSONError.invalidData
    }
    
    return try decode(jsonDictionary: dict)
    
}


public func unpack<T>(key: String, jsonDictionary: JSONDictionary) throws -> T {
    
    guard let raw = jsonDictionary[key] else {
        throw JSONError.notFound(key)
    }
    
    guard let value = raw as? T else {
        throw JSONError.invalidValue(raw, key)
    }
    
    return value
}

public func unpack<T: JSONValueDecodable>(keyPath: String, jsonDictionary: JSONDictionary) throws -> T {
    
    guard let raw = (jsonDictionary as NSDictionary).value(forKeyPath: keyPath) else{
        throw JSONError.notFound(keyPath)
    }
    
    guard let value = raw as? T.Value else {
        throw JSONError.invalidValue(raw, keyPath)
    }
    
    guard let decodedValue = try T(raw: value) else {
        throw JSONError.invalidValue(raw, keyPath)
    }
    
    return decodedValue
    
}

public func unpackDictionary<T: JSONDecodable>(key: String, jsonDictionary: JSONDictionary) throws -> T {
    
    let rawValue: JSONDictionary = try unpack(key: key, jsonDictionary: jsonDictionary)
    return try decode(jsonDictionary: rawValue)
    
}


public func unpackDictionary<T: JSONDecodable>(key: String, jsonDictionary: JSONDictionary) throws -> [T] {
    
    let rawValues: JSONArray = try unpack(key: key, jsonDictionary: jsonDictionary)
    return try decode(jsonArray: rawValues)
    
}


