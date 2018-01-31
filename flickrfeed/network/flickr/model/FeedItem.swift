//
//  FeedItem.swift
//  flickrfeed
//
//  Created by Mateusz Grzegorzek on 31/01/2018.
//  Copyright © 2018 Rivia. All rights reserved.
//

import Foundation

extension Flickr {
    struct FeedItem : Codable {
        var title: String?
        var link: String?
        var media: Flickr.Media?
        var dateTaken: Date?
        var description: String?
        var published: Date?
        var author: String?
        var authorId: String?
        var tags: String?
        
        enum CodingKeys : String, CodingKey {
            case title
            case link
            case media
            case dateTaken = "date_taken"
            case description
            case published
            case author
            case authorId = "author_id"
            case tags
        }
        
    }
}
