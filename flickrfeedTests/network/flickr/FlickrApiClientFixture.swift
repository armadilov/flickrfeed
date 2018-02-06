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
    
    func setupSuccessRequest() {
        stubHttpSuccess(url: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1", jsonFile: "get_photos_public.json")
    }
}
