//
//  ErrorMessageFormatter.swift
//  flickrfeed
//
//  Created by Mateusz Grzegorzek on 06/02/2018.
//  Copyright © 2018 Rivia. All rights reserved.
//

import UIKit

protocol ErrorMessageFormatter {
    func getErrorMessage(_ error: Error) -> String
}

class ErrorMessageFormatterImpl : ErrorMessageFormatter{
    func getErrorMessage(_ error: Error) -> String {
        if let networkServiceError = error as? NetworkServiceError {
            return getNetworkServiceErrorMessage(networkServiceError)
        }
        
        return "Unknown error: \(error)"
    }
    
    fileprivate func getNetworkServiceErrorMessage(_ error: NetworkServiceError) -> String {
        switch(error) {
        case .cancelled:
            return "Request cancelled"
        case .networkNotAvailable:
            return "No internet connection"
        case .serviceNotAvailable(let statusCode):
            return "Service not available \(statusCode)"
        case .invalidResponse:
            return "Invalid service response"
        case .unknown(let error):
            if let error = error as NSError? {
                return "Unknown error (\(error.localizedDescription) [\(error.code)])"
            } else {
                return "Unknown error"
            }
        }
    }
    
}
