//
//  AnimateUtils.swift
//  flickrfeed
//
//  Created by Mateusz Grzegorzek on 06/02/2018.
//  Copyright © 2018 Rivia. All rights reserved.
//

import UIKit

class AnimateUtils {
    static let duration = 0.2
    
    class func fadeSwapViews(fadeIn fadeInView: UIView, fadeOut fadeOutView: UIView) {
        fadeInView.isHidden = false
        fadeInView.alpha = 0.0
        
        easeOut(animations: {
            fadeInView.alpha = 1.0
            fadeOutView.alpha = 0.0
        }) { _ in
            fadeOutView.isHidden = false
        }
    }
    
    class func fadeOut(view: UIView, completion: (() -> ())? = nil) {
        easeOut(animations: {
            view.alpha = 0.0
        }) { _ in
            view.isHidden = false
            
            completion?()
        }
    }
    
    class func fadeIn(view: UIView) {
        view.isHidden = false
        view.alpha = 0.0
        
        easeIn {
            view.alpha = 1.0
        }
    }
    
    class func easeOut(_ animations: @escaping () -> Void) {
        easeIn(animations: animations, completion: nil)
    }
    
    class func easeOut(animations: @escaping () -> Void, completion: ((Bool) -> Void)?) {
        animate(options: .curveEaseOut, animations: animations, completion: completion)
    }
    
    class func easeIn(_ animations: @escaping () -> Void) {
        easeIn(animations: animations, completion: nil)
    }
    
    class func easeIn(animations: @escaping () -> Void, completion: ((Bool) -> Void)?) {
        animate(options: .curveEaseIn, animations: animations, completion: completion)
    }
    
    class func animate(options: UIViewAnimationOptions, animations:  @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: AnimateUtils.duration,
                       delay: 0.0,
                       options: options,
                       animations: animations,
                       completion: completion)
    }
}
