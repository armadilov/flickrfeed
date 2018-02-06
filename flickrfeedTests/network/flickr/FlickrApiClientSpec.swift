//
//  FlickrApiClientTests.swift
//  flickrfeedTests
//
//  Created by Mateusz Grzegorzek on 31/01/2018.
//  Copyright © 2018 Rivia. All rights reserved.
//

import XCTest
import Alamofire

class FlickrApiClientTests: XCTestCase {
    
    func test_loads_items_when_feed_requested() {
        fixture.setupSuccessRequest()
        
        act() { result in
            guard let items = try? result.getValue() else {
                XCTAssert(false)
                return
            }

            XCTAssert(items.count > 0)
        }
    }
    
    func test_loads_required_item_fields_when_feed_requested() {
        fixture.setupSuccessRequest()
        
        act() { result in
            guard let items = try? result.getValue(), let firstItem = items.first else {
                XCTAssert(false)
                return
            }
            XCTAssertNotEmpty(firstItem.title)
            XCTAssertNotEmpty(firstItem.link)
            XCTAssertNotEmpty(firstItem.media?.link)
            XCTAssertNotEmpty(firstItem.author)
            XCTAssertNotNil(firstItem.published)
        }
    }
    
    func test_ignores_items_without_valid_fields_when_feed_requested() {
        XCTFail("Pending")
    }
    
    func test_returns_network_error_when_network_down() {
        XCTFail("Pending")
    }
    
    func test_returns_service_error_when_service_down() {
        XCTFail("Pending")
    }
    
    func test_returns_invalid_response_error_when_response_is_invalid_json() {
        XCTFail("Pending")
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
        stubHttpInitAnyHostBadRequest()
        
        fixture = FlickrApiClientFixture()
    }
    
    override func tearDown() {
        super.tearDown()
        stubHttpTearDown()
    }
    
}
