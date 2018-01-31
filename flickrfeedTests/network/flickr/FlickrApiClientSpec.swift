//
//  FlickrApiClientTests.swift
//  flickrfeedTests
//
//  Created by Mateusz Grzegorzek on 31/01/2018.
//  Copyright © 2018 Rivia. All rights reserved.
//

import XCTest

class FlickrApiClientTests: XCTestCase {
    
    func test_loads_items_when_requested() {
        fixture.setupSuccessRequest()
        
        act() { result in
            guard let items = try? result.getValue() else {
                XCTAssert(false)
                return
            }

            XCTAssert(items.count > 0)
        }
    }
    
    fileprivate func act(completion: @escaping (Result<[Flickr.FeedItem], NetworkServiceError>) -> ()) {
        let expectation = XCTestExpectation(description: "request completes")
        
        fixture.client.getPublicPhotos() { result in
            completion(result)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    fileprivate var fixture: FlickrApiClientFixture!
    
    override func setUp() {
        super.setUp()
        fixture = FlickrApiClientFixture()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
}
