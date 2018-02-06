//
//  OHHTTPSStubs+Utils.swift
//  flickrfeedTests
//
//  Created by Mateusz Grzegorzek on 06/02/2018.
//  Copyright © 2018 Rivia. All rights reserved.
//

import UIKit
import OHHTTPStubs
import XCTest

class BundlePointerClass {
}

public func anyHost() -> OHHTTPStubsTestBlock {
    return { _ in true }
}

public func fixtureText(_ text: String, status: Int32 = 200, headers: [AnyHashable: Any]?) -> OHHTTPStubsResponse {
    return fixture(text.data(using: String.Encoding.utf8)!, status: status, headers: headers)
}

public func fixture(_ data: Data, status: Int32 = 200, headers: [AnyHashable: Any]?) -> OHHTTPStubsResponse {
    return OHHTTPStubsResponse(data: data, statusCode: status, headers: headers)
}

public func fixtureFile(_ fileName: String, status: Int32 = 200, headers: [AnyHashable: Any]?) -> OHHTTPStubsResponse {
    return OHHTTPStubsResponse(fileAtPath: OHPathForFile(fileName, BundlePointerClass.self)!, statusCode: status, headers: headers)
}

public func stubHttpSuccess( url: String, jsonFile: String ) {
    stub(condition: isAbsoluteURLString(url)) { _ in
        return fixtureFile(jsonFile, headers: ["Content-Type":"text/json"])
    }
}

public func stubHttp( url: String, responseText: String, httpStatus: Int32 ) {
    stub(condition: isAbsoluteURLString(url)) { _ in
        return fixtureText(responseText, status: httpStatus, headers: ["Content-Type":"text/plain"])
    }
}

public func stubHttpInitAnyHostBadRequest( ) {
    stub(condition: anyHost()) { response in
        let url = response.url?.absoluteString ?? "<no-url>"
        let message = "INVALID TEST REQUEST: \(url)"
        XCTAssert(false, message)
        return fixtureText(message, status: 400, headers: ["Content-Type":"text/json"])
    }
}

public func stubNetworkDown( ) {
    stub(condition: anyHost()) { response in
        let notConnectedError = NSError(domain: NSURLErrorDomain, code: URLError.notConnectedToInternet.rawValue)
        return OHHTTPStubsResponse(error:notConnectedError)
    }
}


public func stubHttpTearDown( ) {
    OHHTTPStubs.removeAllStubs()
}
