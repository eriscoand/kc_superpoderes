//
//  Resource+ComicVine.swift
//  ComicList
//
//  Created by Eric Risco de la Torre on 12/03/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation
import Networking

let apiKey = "75d580a0593b7320727309feb6309f62def786cd"
private let apiURL = URL(string: "http://comicvine.gamespot.com/api/")!

extension Resource  where M: JSONDecodable{
    
    init(path: String, parameters: [String: String]){
        self.init(url: apiURL.appendingPathComponent(path),
                  parameters: parameters,
                  decode: decode(data:))
    }
    
}
