//
//  Volume.swift
//  ComicList
//
//  Created by Eric Risco de la Torre on 11/03/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation
import Networking

struct Volume {
    
    let id: Int64
    let title: String
    let coverURL: URL?
    let description: String?
    
}

extension Volume: JSONDecodable {
    
    init(jsonDictionary: JSONDictionary) throws {
        self.id = try unpack(key: "id", jsonDictionary: jsonDictionary) ?? 0
        self.title = try unpack(key: "name", jsonDictionary: jsonDictionary)
        self.coverURL = try unpack(keyPath: "image.small_url", jsonDictionary: jsonDictionary)
        self.description = try unpack(key: "description", jsonDictionary: jsonDictionary)
    }
    
}

extension Volume {
    
    public static func titles(query: String) -> Resource<Response<Volume>> {
        return Resource.init(path:"search",
                             parameters: [
                                "api_key": apiKey,
                                "format": "json",
                                "field_list": "name",
                                "limit": "10",
                                "page": "1",
                                "query": query,
                                "resources": "volume"
                            ]
        )
    }
    
}
