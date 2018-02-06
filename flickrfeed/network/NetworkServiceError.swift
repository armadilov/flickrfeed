//
//  NetworkServiceError.swift
//  flickrfeed
//
//  Created by Mateusz Grzegorzek on 31/01/2018.
//  Copyright © 2018 Rivia. All rights reserved.
//

import Foundation

enum NetworkServiceError: Error, Equatable {
    case cancelled
    case networkNotAvailable
    case serviceNotAvailable(Int)
    case invalidResponse(Error?)
    case unknown(Error?)
    
    static func from(httpResponse: HTTPURLResponse?, error: Error?) -> NetworkServiceError {
        if let httpResponse = httpResponse {
            return serviceNotAvailable(httpResponse.statusCode)
        } else if let error = error as NSError?, error.code == -1009 || error.code == -1001 {  //CFNetworkErrors.CFURLErrorNotConnectedToInternet
            return networkNotAvailable
        } else {
            return unknown(error)
        }
    }
}

func ==(lhs: NetworkServiceError, rhs: NetworkServiceError) -> Bool {
    switch (lhs, rhs) {
    case (.cancelled, .cancelled):
        return true
    case (.networkNotAvailable, .networkNotAvailable):
        return true
    case (.serviceNotAvailable(let leftStatus), .serviceNotAvailable(let rightStatus)):
        return leftStatus == rightStatus
    case (.invalidResponse(let leftError), .invalidResponse(let rightError)):
        return leftError?.localizedDescription == rightError?.localizedDescription
    case (.unknown(let leftError), .unknown(let rightError)):
        return leftError?.localizedDescription == rightError?.localizedDescription
    default:
        return false
    }
}
