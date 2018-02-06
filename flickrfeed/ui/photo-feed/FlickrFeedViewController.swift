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
    }
}

extension FlickrFeedViewController : FlickrFeedViewModelDelegate {
    
}
