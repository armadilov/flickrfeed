//
//  UIView+Utils.swift
//  flickrfeed
//
//  Created by Mateusz Grzegorzek on 06/02/2018.
//  Copyright © 2018 Rivia. All rights reserved.
//

import UIKit

extension UIView {
    func firstSuperview<T>(ofType type: T.Type) -> T? {
        var currentView: UIView? = self
        
        while currentView != nil {
            if currentView is T {
                break
            } else {
                currentView = currentView?.superview
            }
        }
        
        return currentView as? T
    }
}

protocol NibInstantiable : class {
    static func nib() -> UINib
    static func instanceFromNib() -> Self
    static func instanceFromNib(at index: Int) -> Self
}

extension NibInstantiable where Self : UIView {
    func validateConfig() {
    }
    
    static func nib() -> UINib {
        let className = NSStringFromClass(Self.self).components(separatedBy: ".").last!
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: className, bundle: bundle)
        return nib
    }
    
    static func instanceFromNib() -> Self {
        return instanceFromNib(at: 0)
    }
    
    static func instanceFromNib(at index: Int) -> Self {
        let nib = Self.nib()
        let view: Self = nib.instantiate(withOwner: nil, options: nil)[index] as! Self
        view.validateConfig()
        return view
    }
}
