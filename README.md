# Flickr Feed example app

![FlickrFeed screenshot](https://raw.githubusercontent.com/armadilov/flickrfeed/master/docs/images/flickrfeed.png "Sample screen")

**Description**
The app downloads and displays public photo feed from Flickr using their feed API. 
You can also filter the feed by specifiyng additional tag search.

**Implementation notes**

1. The app uses is written in Swift 4 language using MVVM Architecture
    
1. Unit Test are written using default Xcode XCTest framework

1. REST Api unit tests are stubbed by [OHHTTPStubs](https://github.com/AliSoftware/OHHTTPStubs) library with some additional helper methods

1. RxSwift is used to delay tag filtering search trigger


