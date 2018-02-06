//
//  UIViewController+Utils.swift
//  flickrfeed
//
//  Created by Mateusz Grzegorzek on 06/02/2018.
//  Copyright © 2018 Rivia. All rights reserved.
//

import UIKit
import SwiftMessages

extension UIViewController {
    func showError(message: String, title: String = "Error") {
       showNotification(theme: .error, title: title, message: message)
    }
    
    func showSuccess(message: String, title: String = "Success") {
        showNotification(theme: .success, title: title, message: message)
    }
    
    func showWarning(message: String, title: String = "Warning") {
        showNotification(theme: .warning, title: title, message: message)
    }
    
    func showInfo(message: String, title: String = "Info") {
        showNotification(theme: .info, title: title, message: message)
    }
    
    fileprivate func showNotification(theme: Theme, title: String, message: String ) {
        let view = MessageView.viewFromNib(layout: .messageView)
        view.configureTheme(theme)
        view.configureContent(title: title, body: message)
        view.button?.removeFromSuperview()
        view.button = nil
        
        var config = SwiftMessages.Config()
        config.presentationContext = .automatic
        SwiftMessages.show(config: config, view: view)
    }
}
