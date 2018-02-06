//
//  FlickrFeedViewModel.swift
//  flickrfeed
//
//  Created by Mateusz Grzegorzek on 06/02/2018.
//  Copyright © 2018 Rivia. All rights reserved.
//

import UIKit

protocol FlickrFeedViewModelDelegate : class {
    
}

protocol FlickrFeedViewModel {
    
}

class FlickrFeedViewModelImpl : FlickrFeedViewModel {
    fileprivate weak var delegate: FlickrFeedViewModelDelegate!
    
    init( delegate: FlickrFeedViewModelDelegate ) {
        self.delegate = delegate
        
    }
}
