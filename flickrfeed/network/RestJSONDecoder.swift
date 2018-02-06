//
//  RestJSONDecoder.swift
//  flickrfeed
//
//  Created by Mateusz Grzegorzek on 06/02/2018.
//  Copyright © 2018 Rivia. All rights reserved.
//

import UIKit

class RestJSONDecoder: JSONDecoder {
    
    override init() {
        super.init()
        
        self.dateDecodingStrategy = .iso8601
    }

}
