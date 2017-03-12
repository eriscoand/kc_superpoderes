//
//  Response.swift
//  ComicList
//
//  Created by Eric Risco de la Torre on 11/03/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation
import Networking

struct Response<T: JSONDecodable> {
    
    let status: Int
    let message: String
    let results: [T]
    
}

extension Response: JSONDecodable {
    
    init(jsonDictionary: JSONDictionary) throws {
        self.status = try unpack(key: "status_code", jsonDictionary: jsonDictionary)
        self.message = try unpack(key: "message", jsonDictionary: jsonDictionary)
        
        if let value: T = try? unpackDictionary(key: "results", jsonDictionary: jsonDictionary){
            self.results = [value]
        }else{
            self.results = try unpackDictionary(key: "results", jsonDictionary: jsonDictionary)
        }
        
    }
    
}
