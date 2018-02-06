//
//  FlickrFeedViewController.swift
//  flickrfeed
//
//  Created by Mateusz Grzegorzek on 06/02/2018.
//  Copyright © 2018 Rivia. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import RxSwift

private enum CellIdentifier : String {
    case feedItem = "feedItemCell"
}

class FlickrFeedViewController: UIViewController {
    fileprivate var viewModel: FlickrFeedViewModel!
    
    @IBOutlet fileprivate weak var searchBar: UISearchBar!
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var activityView: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = FlickrFeedViewModelImpl( delegate: self )
        viewModel.load()
        
        registerCells()
    }
    
    fileprivate func registerCells() {
        let cellNib = FlickrFeedItemTableViewCell.nib()
        tableView.register(cellNib, forCellReuseIdentifier: CellIdentifier.feedItem.rawValue)
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

extension FlickrFeedViewController : UITableViewDelegate {
}

extension FlickrFeedViewController : UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.feedItem.rawValue, for: indexPath) as? FlickrFeedItemTableViewCell else {
            return UITableViewCell()
        }
        
        cell.dataContext = viewModel.items[indexPath.row]
        
        return cell
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
    }
    
    
}
