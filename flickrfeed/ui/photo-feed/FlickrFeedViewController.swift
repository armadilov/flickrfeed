//
//  FlickrFeedViewController.swift
//  flickrfeed
//
//  Created by Mateusz Grzegorzek on 06/02/2018.
//  Copyright © 2018 Rivia. All rights reserved.
//

import UIKit

class FlickrFeedViewController: UIViewController {
    fileprivate var viewModel: FlickrFeedViewModel!
    
    @IBOutlet fileprivate weak var searchBar: UISearchBar!
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = FlickrFeedViewModelImpl( delegate: self )
        viewModel.load()
    }
    
    fileprivate func showActivity() {
        
    }
    
    fileprivate func hideActivity() {
        
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
