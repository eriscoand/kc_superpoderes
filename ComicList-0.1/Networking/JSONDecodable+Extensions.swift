//
//  JSONDecodable+Extensions.swift
//  ComicList 0.1
//
//  Created by Eric Risco de la Torre on 13/03/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation

extension Int64: JSONValueDecodable {
    
    public init?(raw: Int){
        self.init(raw)
    }
    
}

extension URL: JSONValueDecodable {
    
    public init?(raw: String){
        self.init(string: raw)
    }
    
}

extension String: JSONValueDecodable {
    
    public init?(raw: String){
        self.init(raw)
    }
    
}

extension JSONValueDecodable where Self: RawRepresentable {
    
    public init?(raw: Self.RawValue){
        self.init(rawValue: raw)
    }
    
}
