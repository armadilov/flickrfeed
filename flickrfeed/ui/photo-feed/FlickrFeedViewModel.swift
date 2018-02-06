//
//  FlickrFeedViewModel.swift
//  flickrfeed
//
//  Created by Mateusz Grzegorzek on 06/02/2018.
//  Copyright © 2018 Rivia. All rights reserved.
//

import UIKit

protocol FlickrFeedViewModelDelegate : class {
    func viewModelDidBeginRequest()
    
    func viewModelDidEndRequest()
    
    func viewModelDidEncounterError(errorMessage: String)
    
    func viewModelDidLoadItems()
}

protocol FlickrFeedViewModel {
    var items: [Flickr.FeedItem] { get }
    
    func load()
}

class FlickrFeedViewModelImpl : FlickrFeedViewModel {
    fileprivate let flickrApiClient: FlickrApiClient
    fileprivate let errorMessageFormatter: ErrorMessageFormatter
    
    fileprivate weak var delegate: FlickrFeedViewModelDelegate!
    
    fileprivate (set) var items: [Flickr.FeedItem] = []
    
    init( delegate: FlickrFeedViewModelDelegate,
          flickrApiClient: FlickrApiClient = FlickrApiClientImpl(),
          errorMessageFormatter: ErrorMessageFormatter = ErrorMessageFormatterImpl()) {
        self.delegate = delegate
        self.flickrApiClient = flickrApiClient
        self.errorMessageFormatter = errorMessageFormatter
    }
    
    func load() {
        delegate.viewModelDidBeginRequest()
        
        self.flickrApiClient.getPublicPhotos { [weak self] result in
            guard let self_ = self else { return }
            
            self_.delegate.viewModelDidEndRequest()
            
            do {
                self_.items = try result.getValue()
                self_.delegate.viewModelDidLoadItems()
            } catch {
                self_.handle(error: error)
            }
        }
    }
    
    fileprivate func handle(error: Error) {
        let errorMessage = errorMessageFormatter.getErrorMessage(error);
        delegate.viewModelDidEncounterError(errorMessage: errorMessage)
    }
}
