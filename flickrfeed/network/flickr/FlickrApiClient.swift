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
    func getPublicPhotos(tags: [String], completion: @escaping (Result<[Flickr.FeedItem], NetworkServiceError>) -> ())
}

class FlickrApiClientImpl: FlickrApiClient {
    fileprivate let getPhotosPublicUrl = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1"
    
    func getPublicPhotos(tags: [String] = [], completion: @escaping (Result<[Flickr.FeedItem], NetworkServiceError>) -> ()) {
        
        var url = getPhotosPublicUrl
        if (tags.count > 0) {
            let tagParams = tags.map { $0.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "" }
            url = url + "&tags=" + tagParams.joined(separator:",")
        }
        Alamofire.request(url).responseData { response in
            guard let httpStatus = response.response?.statusCode, httpStatus == 200, let data = response.result.value else {
                completion(Result.failure(NetworkServiceError.from(httpResponse: response.response, error: response.error)))
                return
            }
            
            do {
                let decoder = RestJSONDecoder()
                let photoFeed = try decoder.decode(Flickr.PhotoFeed.self, from: data)
                
                var items = photoFeed.items;
                items.remove { String.isNilOrEmpty( $0.media?.link ) }
                completion(Result.success(items))
            } catch {
                completion(Result.failure(NetworkServiceError.invalidResponse(error)))
            }
        }
    }
}
