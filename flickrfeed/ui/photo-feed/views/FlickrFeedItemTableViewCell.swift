//
//  FlickrFeedItemTableViewCell.swift
//  flickrfeed
//
//  Created by Mateusz Grzegorzek on 06/02/2018.
//  Copyright © 2018 Rivia. All rights reserved.
//

import UIKit
import SwiftyImageCache

protocol FlickrFeedItemTableViewCellDelegate : class {
    func requestReload(cell: FlickrFeedItemTableViewCell)
}

fileprivate var imageSizeCache: [String : CGSize] = [:]

final class FlickrFeedItemTableViewCell: UITableViewCell, NibInstantiable {
    @IBOutlet fileprivate weak var authorLabel: UILabel!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var photoImageView: UIImageView!
    @IBOutlet fileprivate weak var photoHeightConstraint: NSLayoutConstraint!
    
    weak var delegate: FlickrFeedItemTableViewCellDelegate?
    var dataContext : Flickr.FeedItem? { didSet { updateView() } }
    
    fileprivate func updateView() {
        authorLabel.text = dataContext?.author ?? "-"
        titleLabel.text = dataContext?.title ?? ""
        photoImageView.image = nil
        
        let urlText = dataContext?.media?.link ?? ""
        let didUpdateHeightFromCache = self.updateHeightConstraint(for: urlText)
        
        if let url = URL(string: urlText) {
            ImageCache.default.loadImage(atUrl: url, completion: { [weak self] (urlString, image) in
                guard let self_ = self, let image = image else {
                    return
                }
                
                if (!didUpdateHeightFromCache) {
                    // Note: I want to resize the table dynamically after the image is loaded
                    // normally it would be best if Flickr image feed would return image size in REST response
                    // however, since that's not possible, we need to do a trick here to store the image sizes after they're downloaded
                    // and request tableView reload so it will play out nicely with scorlling/etc.
                    imageSizeCache[urlText] = image.size
                    _ = self_.updateHeightConstraint(for: urlText)
                    self_.delegate?.requestReload(cell: self_)
                }
                
                self_.photoImageView.image = image
                return
            })
        }
    }
    
    fileprivate func updateHeightConstraint(for url: String) -> Bool {
        if let imageSize = imageSizeCache[url] {
            let ratio = imageSize.height / imageSize.width
            let height = self.frame.size.width * ratio
            photoHeightConstraint.constant = height

            return true
        }
        
        photoHeightConstraint.constant = self.frame.size.width * 0.66
        return false
        
    }
}
