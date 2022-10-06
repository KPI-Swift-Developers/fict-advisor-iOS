//
//  SearchCoreViewController.swift
//  fictadvisor-iOS
//
//  Created by Jeytery on 30.09.2022.
//

import UIKit

class SearchCoreViewController: CoreViewController {
    
    override init(
        buttonImage1: UIImage? = UIImage(systemName: ""),
        buttonImage2: UIImage? = UIImage(systemName: ""),
        largeNavigation: Bool = true
    ) {
        super.init(
            buttonImage1: buttonImage1,
            buttonImage2: buttonImage2,
            largeNavigation: largeNavigation
        )
        searchVC.searchResultsUpdater = self
        
        navigationItem.searchController = searchVC
        searchVC.hidesNavigationBarDuringPresentation = false
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private let searchVC = UISearchController()
    func didEnterTextIn(_ searchBarViewController: UISearchController) {}
}

extension SearchCoreViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        didEnterTextIn(searchController)
    }
}
