//
//  JSONDecodable+Errors.swift
//  ComicList 0.1
//
//  Created by Eric Risco de la Torre on 13/03/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation

public enum JSONError: Error {
    case invalidData
    case notFound(String)
    case invalidValue(Any, String)
}
