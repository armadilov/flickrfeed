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
import RxCocoa

private enum CellIdentifier : String {
    case feedItem = "feedItemCell"
}

class FlickrFeedViewController: UIViewController {
    fileprivate var viewModel: FlickrFeedViewModel!
    fileprivate var disposeBag: DisposeBag = DisposeBag()
    fileprivate var dataLoadFromPullToRefresh = false
    
    @IBOutlet fileprivate weak var searchBar: UISearchBar!
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var activityOverlayView: UIView!
    @IBOutlet fileprivate weak var activityIndicatorView: NVActivityIndicatorView!
    @IBOutlet fileprivate weak var noItemsView: UIView!
    fileprivate var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = FlickrFeedViewModelImpl( delegate: self )
        viewModel.load()
        
        setupPullToRefresh()
        registerCells()
        setupSearchBar()
    }
    
    fileprivate func setupPullToRefresh() {
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor(red: 0.2, green: 0.4, blue: 0.69, alpha: 1.0)
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: UIControlEvents.valueChanged)
        
        tableView.refreshControl = refreshControl
    }
    
    fileprivate func registerCells() {
        let cellNib = FlickrFeedItemTableViewCell.nib()
        tableView.register(cellNib, forCellReuseIdentifier: CellIdentifier.feedItem.rawValue)
    }
    
    @objc func refreshData(_ sender: AnyObject) {
        dataLoadFromPullToRefresh = true
        viewModel.load()
    }
    
    fileprivate func setupSearchBar() {
        searchBar.rx.text.orEmpty
            .debounce(0.35, scheduler: MainScheduler.instance)
            .distinctUntilChanged( { $0 == $1 })
            .observeOn(MainScheduler.instance)
            .subscribe({ [weak self] in
                guard let self_ = self else { return }
                self_.viewModel.tags = $0.element ?? ""
            }).disposed(by: disposeBag)
    }
    
    fileprivate func showActivity() {
        if dataLoadFromPullToRefresh {
            return
        }
        
        activityIndicatorView.startAnimating()
        AnimateUtils.fadeIn(view: activityOverlayView)
    }
    
    fileprivate func hideActivity() {
        dataLoadFromPullToRefresh = false
        self.refreshControl?.endRefreshing()
        AnimateUtils.fadeOut(view: activityOverlayView) { [weak self] in
            guard let self_ = self else { return }
            
            self_.activityIndicatorView.stopAnimating()
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
        AnimateUtils.fadeOut(view: noItemsView)
    }
    
    func viewModelDidEndRequest() {
        hideActivity()
    }
    
    func viewModelDidEncounterError(errorMessage: String) {
        showError(message: errorMessage)
    }
    
    func viewModelDidLoadItems() {
        self.tableView.reloadData()
        
        if (viewModel.items.count == 0) {
            AnimateUtils.fadeIn(view: noItemsView)
        }
    }
    
    
}
