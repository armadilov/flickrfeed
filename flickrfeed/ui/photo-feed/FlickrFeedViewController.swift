//
//  FlickrFeedViewController.swift
//  flickrfeed
//
//  Created by Mateusz Grzegorzek on 06/02/2018.
//  Copyright © 2018 Rivia. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class FlickrFeedViewController: UIViewController {
    fileprivate var viewModel: FlickrFeedViewModel!
    
    @IBOutlet fileprivate weak var searchBar: UISearchBar!
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var activityView: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = FlickrFeedViewModelImpl( delegate: self )
        viewModel.load()
    }
    
    fileprivate func showActivity() {
        activityView.startAnimating()
        AnimateUtils.fadeIn(view: activityView)
    }
    
    fileprivate func hideActivity() {
        AnimateUtils.fadeOut(view: activityView) { [weak self] in
            guard let self_ = self else { return }
            
            self_.activityView.stopAnimating()
        }
    }
}

extension FlickrFeedViewController : FlickrFeedViewModelDelegate {
    func viewModelDidBeginRequest() {
        showActivity()
    }
    
    func viewModelDidEndRequest() {
        hideActivity()
    }
    
    func viewModelDidEncounterError(errorMessage: String) {
        showError(message: errorMessage)
    }
    
    func viewModelDidLoadItems() {
        self.tableView.reloadData()
        showSuccess(message: "Items loaded")
    }
    
    
}
