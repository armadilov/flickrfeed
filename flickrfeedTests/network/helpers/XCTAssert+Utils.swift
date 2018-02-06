//
//  XCTAssert+Utils.swift
//  flickrfeedTests
//
//  Created by Mateusz Grzegorzek on 06/02/2018.
//  Copyright © 2018 Rivia. All rights reserved.
//

import XCTest

func XCTAssertNotEmpty(_ s: String?, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) {
    XCTAssert((s?.count ?? 0) > 0, message, file: file, line: line)
}