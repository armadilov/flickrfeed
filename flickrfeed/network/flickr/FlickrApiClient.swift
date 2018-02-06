//
//  FlickrApiClient.swift
//  flickrfeed
//
//  Created by Mateusz Grzegorzek on 31/01/2018.
//  Copyright © 2018 Rivia. All rights reserved.
//

import Foundation
import Alamofire

// Namespace for Flickr entities
enum Flickr {}

protocol FlickrApiClient {
    func getPublicPhotos(completion: @escaping (Result<[Flickr.FeedItem], NetworkServiceError>) -> ())
}

class FlickrApiClientImpl: FlickrApiClient {
    fileprivate let getPhotosPublicUrl = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1"
    
    func getPublicPhotos(completion: @escaping (Result<[Flickr.FeedItem], NetworkServiceError>) -> ()) {
        
        Alamofire.request(getPhotosPublicUrl).responseJSON { response in
            guard let _ = response.result.value else {
                completion(Result.failure(NetworkServiceError.from(httpResponse: response.response, error: response.error)))
                return
            }
            
            completion(Result.failure(NetworkServiceError.serviceNotAvailable(500)))
        }
    }
}
