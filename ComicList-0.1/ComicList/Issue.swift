//
//  Issue.swift
//  ComicList 0.1
//
//  Created by Eric Risco de la Torre on 13/03/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation
import Networking

public struct Issue {
    
    public let issue_id: Int64
    public let volume: Volume
    
}

extension Issue: JSONDecodable {
    
    public init(jsonDictionary: JSONDictionary) throws {
        
        let volumeIdentifier: Int64 = try unpack(keyPath: "volume.id", jsonDictionary: jsonDictionary)
        
        let volumeTitle: String = try unpack(keyPath: "volume.name", jsonDictionary: jsonDictionary)
        let volumeCoverURL: URL = try unpack(keyPath: "image.small_url", jsonDictionary: jsonDictionary)
        
        self.issue_id = try unpack(key: "id", jsonDictionary: jsonDictionary)
        self.volume = Volume(id: volumeIdentifier, title: volumeTitle, coverURL: volumeCoverURL, description: nil)
        
    }

}

extension Issue {
    
    public static func issues(fromVolume volume_id: Int64) -> Resource<Response<Issue>> {
        return Resource(
            path: "issues",
            parameters: [
                "api_key": apiKey,
                "field_list": "id,image,name,volume",
                "limit": "10",
                "page": "1",
                "filter": "volume:" + String(volume_id),
                "format": "json"
            ]
        )
    }
    
    
}
