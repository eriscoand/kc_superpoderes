//
//  JSONDecodable+Protocols.swift
//  ComicList 0.1
//
//  Created by Eric Risco de la Torre on 13/03/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation

public protocol JSONDecodable {
    init(jsonDictionary: JSONDictionary) throws
}

public protocol JSONValueDecodable {
    associatedtype Value
    init?(raw: Value) throws
}
