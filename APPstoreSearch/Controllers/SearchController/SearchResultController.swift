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
    private let cellID = "cellID"
    private let headerCellID = "headerCellID"
    let searchController = UISearchController(searchResultsController: nil)
    let search = Search()
    var downloadTask: URLSessionDownloadTask?

    

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
        return search.searchResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CategoryCell
        
        let item = search.searchResults[indexPath.item]
        cell.categoryItem = item
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCellID, for: indexPath) as! HeaderCell
        
        if search.isLoading {
            header.loadingIndicator.startAnimating()
            header.textLabel.text = "Loading..."
        } else if search.searchResults.count == 0 {
            header.textLabel.text = "Nothing Found"
        }
        
        return header
    }

    
    
    //MARK: - Methods
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




