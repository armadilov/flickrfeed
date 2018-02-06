//
//  String+Utils.swift
//  flickrfeed
//
//  Created by Mateusz Grzegorzek on 06/02/2018.
//  Copyright © 2018 Rivia. All rights reserved.
//

import UIKit

extension String {
    static func isNilOrEmpty(_ string: String?) -> Bool {
        return string?.count ?? 0 == 0
    }
    
    static func hasContent(_ string: String?) -> Bool {
        return isNilOrEmpty(string) == false
    }
    
}
