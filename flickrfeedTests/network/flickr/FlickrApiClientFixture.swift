//
//  FlickrApiClientFixture.swift
//  flickrfeedTests
//
//  Created by Mateusz Grzegorzek on 31/01/2018.
//  Copyright © 2018 Rivia. All rights reserved.
//

import UIKit

class FlickrApiClientFixture {
    let client: FlickrApiClient = FlickrApiClientImpl()
    fileprivate let apiPhotosFeedUrl = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1"
    
    func setupSuccessRequest() {
        stubHttpSuccess(url: apiPhotosFeedUrl, jsonFile: "get_photos_public.json")
    }
    
    func setupPartialInvalidItemsRequest() {
        stubHttpSuccess(url: apiPhotosFeedUrl, jsonFile: "get_photos_public_with_invalid_items.json")
    }
    
    func setupServiceDown() {
        stubHttp(url: apiPhotosFeedUrl, responseText: "INTERNAL SERVER ERROR", httpStatus: 500)
    }
    
    func setupInvalidJsonResponse() {
        stubHttp(url: apiPhotosFeedUrl, responseText: "Non JSON Response", httpStatus: 200)
    }
}
