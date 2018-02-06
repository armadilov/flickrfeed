//
//  FlickrFeedItemTableViewCell.swift
//  flickrfeed
//
//  Created by Mateusz Grzegorzek on 06/02/2018.
//  Copyright © 2018 Rivia. All rights reserved.
//

import UIKit
import SwiftyImageCache

final class FlickrFeedItemTableViewCell: UITableViewCell, NibInstantiable {
    @IBOutlet fileprivate weak var authorLabel: UILabel!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var photoImageView: UIImageView!
    
    var dataContext : Flickr.FeedItem? { didSet { updateView() } }
    
    fileprivate func updateView() {
        authorLabel.text = dataContext?.author ?? "-"
        titleLabel.text = dataContext?.title ?? ""
        photoImageView.image = nil
        
        let urlText = dataContext?.media?.link ?? ""
        if let url = URL(string: urlText) {
            self.photoImageView.alpha = 0.0
            self.photoImageView.setUrl(url) { _ in
                AnimateUtils.fadeIn(view: self.photoImageView)
            }
        }
    }
}
