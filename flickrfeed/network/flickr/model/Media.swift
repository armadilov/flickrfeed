//
//  Media.swift
//  flickrfeed
//
//  Created by Mateusz Grzegorzek on 31/01/2018.
//  Copyright © 2018 Rivia. All rights reserved.
//

import Foundation

extension Flickr {
    struct Media : Codable {
        var link: String?
        
        enum CodingKeys : String, CodingKey {
            case link = "m"
        }
    }
}
