//
//  Array+Utils.swift
//  flickrfeed
//
//  Created by Mateusz Grzegorzek on 06/02/2018.
//  Copyright © 2018 Rivia. All rights reserved.
//

import UIKit

extension Array {
    @discardableResult
    mutating func remove(where predicate: (Element) -> Bool) -> [Element] {
        var removedElements: [Element] = []
        while let index = self.index(where: predicate) {
            removedElements.append(self.remove(at: index))
        }
        return removedElements
    }
    
    func all(match predicate: (Element) -> Bool) -> Bool {
        return self.first { !predicate($0) } == nil
    }

}
