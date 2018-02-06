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
    
    func test_loads_tagged_items_when_feed_filtering_by_tags() {
        fixture.setupTagRequest()
        
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
                XCTAssert(false, result.debugDescription)
                return
            }
            
            XCTAssertNotEmpty(firstItem.title)
            XCTAssertNotEmpty(firstItem.link)
            XCTAssertNotEmpty(firstItem.media?.link)
            XCTAssertNotEmpty(firstItem.author)
            XCTAssertNotNil(firstItem.published)
        }
    }
    
    func test_ignores_items_without_media_link_when_feed_requested() {
        fixture.setupPartialInvalidItemsRequest()
        
        act() { result in
            guard let items = try? result.getValue() else {
                XCTAssert(false, result.debugDescription)
                return
            }
            
            XCTAssertEqual(items.count, 1)
            XCTAssert(items.all { String.hasContent($0.media?.link) })
        }
    }
    
    func test_returns_network_error_when_network_down() {
        stubNetworkDown()
        
        act() { result in
            XCTAssertThrows(error: NetworkServiceError.networkNotAvailable) { try _ = result.getValue() }
        }
    }
    
    func test_returns_service_error_when_service_down() {
        fixture.setupServiceDown()
        
        act() { result in
            XCTAssertThrows(error: NetworkServiceError.serviceNotAvailable(500)) { try _ = result.getValue() }
        }
    }
    
    func test_returns_invalid_response_error_when_response_is_invalid_json() {
        fixture.setupInvalidJsonResponse()
        
        act() { result in
            XCTAssertThrows(error: NetworkServiceError.invalidResponse(nil)) { try _ = result.getValue() }
        }
    }
    
    fileprivate func act(completion: @escaping (Result<[Flickr.FeedItem], NetworkServiceError>) -> ()) {
        let expectation = XCTestExpectation(description: "request completes")
        
        fixture.client.getPublicPhotos(tags: fixture.tags) { result in
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
