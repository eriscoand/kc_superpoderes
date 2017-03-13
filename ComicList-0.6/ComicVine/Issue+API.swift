//
//  Issue+API.swift
//  ComicList
//
//  Created by Eric Risco de la Torre on 12/03/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation
import Networking

extension Issue {
    
    public static func issues(fromVolume volume_id: Int64) -> Resource<Response<Issue>> {
        return Resource(
            comicVinePath: "issues",
            parameters: [
                "field_list": "id,image,name,volume",
                "limit": "10",
                "filter": "volume:" + String(volume_id),
                "format": "json"
            ]
        )
    }
    
}

