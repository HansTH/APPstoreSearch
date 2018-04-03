//
//  SearchResultController.swift
//  APPstoreSearch
//
//  Created by Hans ter Horst on 28-03-18.
//  Copyright © 2018 Hans ter Horst. All rights reserved.
//

import UIKit

class SearchResultController: UICollectionViewController {
    
    //MARK: Properties
    private var cellID = "cellID"
    private let headerCellID = "headerCellID"
    let searchController = UISearchController(searchResultsController: nil)
    let search = Search()
//    var downloadTask: URLSessionDownloadTask?

    

    //MARK: - SearchResultController methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        navigationItem.title = "APPstore Search"
        searchController.searchBar.delegate = self
        
        // Register Cell classes
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: cellID)
        collectionView?.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerCellID)
        
        // Setup SearchController
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search the App store for ..."
        searchController.searchBar.becomeFirstResponder()
        searchController.searchBar.scopeButtonTitles = ["All", "iOS", "iPad", "Mac", "Developer"]
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
               
    }

    
    
    //MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch search.state {
        case .noResults, .notSearchedYet, .loading:
            return 0
        case .results(let list):
            return list.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CategoryCell
        
        switch search.state {
        case .noResults, .notSearchedYet, .loading:
            break
        case .results(let list):
            let item = list[indexPath.item]
            cell.categoryItem = item
            cell.searchResultController = self
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCellID, for: indexPath) as! HeaderCell
        
        switch search.state {
        case .noResults:
            header.titleLabel.text = "Nothing found"
            header.textLabel.text = "Please search for something else."
        case .notSearchedYet:
            header.titleLabel.text = "No search result."
            header.textLabel.text = "Please make a search request\nby using the search bar above."
        case .loading:
            header.loadingIndicator.startAnimating()
            header.titleLabel.text = "Loading..."
            header.textLabel.text = ""
        case .results(_):
            break
        }
        
        return header
    }

    
    
    //MARK: - Methods
    func showAppDetailsFor(app: SearchResult) {
        let layout = UICollectionViewFlowLayout()
        let appDetailController = AppDetailController(collectionViewLayout: layout)
        navigationController?.pushViewController(appDetailController, animated: true)
    }
    
    func performSearch() {
        
        if let category = Search.Category(rawValue: searchController.searchBar.selectedScopeButtonIndex) {
            
            collectionView?.reloadData()
            
            search.performSearch(with: searchController.searchBar.text!, category: category, completion: { success in
                if !success {
                    self.showNetworkError()
                }
                self.collectionView?.reloadData()
            })
            
            collectionView?.reloadData()
            searchController.searchBar.resignFirstResponder()
        }
    }
    
    func showNetworkError() {
        let title = "Whoops..."
        let message = "There was an error accessing the iTunes Store.\nPlease try again."
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            self.searchController.searchBar.text = ""
        }
        
        alert.addAction(action)
        
        searchController.dismiss(animated: true, completion: nil)
        present(alert, animated: true, completion: nil)
    }

}




