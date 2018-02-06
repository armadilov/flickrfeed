//
//  PhotoFeed.swift
//  flickrfeed
//
//  Created by Mateusz Grzegorzek on 06/02/2018.
//  Copyright © 2018 Rivia. All rights reserved.
//

import Foundation

extension Flickr {
    struct PhotoFeed : Codable {
        var title: String?
        var link: String?
        var description: String?
        var modified: Date?
        var generator: String?
        var items: [FeedItem]
        
        
    }
}
