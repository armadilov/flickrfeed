//
//  DispatchUtils.swift
//  flickrfeed
//
//  Created by Mateusz Grzegorzek on 06/02/2018.
//  Copyright © 2018 Rivia. All rights reserved.
//

import UIKit

func dispatch_on_main(_ block: @escaping ()->()) {
    if (Thread.isMainThread) {
        block()
    } else {
        DispatchQueue.main.async(execute: block)
    }
}

func dispatch_on_next_main(_ block: @escaping ()->()) {
    DispatchQueue.main.async(execute: block)
}

func dispatch_on_background(_ block: @escaping ()->()) {
    DispatchQueue.global().async(execute: block)
}

func dispatch_on_main(delay: TimeInterval, block: @escaping ()->()) {
    dispatch_after_delay(delay, queue: DispatchQueue.main, block: block)
}

func dispatch_after_delay(_ delay: TimeInterval, queue: DispatchQueue, block: @escaping ()->()) {
    let time = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    queue.asyncAfter(deadline: time, execute: block)
}

