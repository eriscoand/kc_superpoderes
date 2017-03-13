//
//  Issue+JSONDecodable.swift
//  ComicList
//
//  Created by Eric Risco de la Torre on 12/03/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation
import Networking

extension Issue: JSONDecodable {
    
    public init(jsonDictionary: JSONDictionary) throws {
        
        guard let volume_title = (jsonDictionary as NSDictionary).value(forKeyPath: "volume.name") as? String else {
            throw JSONError.unsupportedType
        }
        
        let volume_coverURL = ((jsonDictionary as NSDictionary)
                                    .value(forKeyPath: "image.small_url") as? String)
                                    .flatMap { URL(string: $0) }
        
        let volume_identifier = (jsonDictionary as NSDictionary).value(forKeyPath: "volume.id") as? Int64 ?? 0
        
        let volume = Volume(identifier: volume_identifier,
                            title: volume_title,
                            coverURL: volume_coverURL,
                            publisherName: nil,
                            description: nil)
        
        self.issue_id = jsonDictionary["id"] as? Int64 ?? 0
        self.volume = volume
        
    }
}
