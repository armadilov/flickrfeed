//
//  FlickrApiClient.swift
//  flickrfeed
//
//  Created by Mateusz Grzegorzek on 31/01/2018.
//  Copyright © 2018 Rivia. All rights reserved.
//

import Foundation

// Namespace for Flickr entities
enum Flickr {}

protocol FlickrApiClient {
    func getPublicPhotos(completion: @escaping (Result<[Flickr.FeedItem], NetworkServiceError>) -> ())
}

class FlickrApiClientImpl: FlickrApiClient {

    func getPublicPhotos(completion: @escaping (Result<[Flickr.FeedItem], NetworkServiceError>) -> ()) {
        completion(Result.failure(NetworkServiceError.serviceNotAvailable(500)))
    }
}
