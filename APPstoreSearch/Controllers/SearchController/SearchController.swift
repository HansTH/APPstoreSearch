//
//  SearchController.swift
//  APPstoreSearch
//
//  Created by Hans ter Horst on 28-03-18.
//  Copyright © 2018 Hans ter Horst. All rights reserved.
//

import UIKit

class SearchController: UICollectionViewController {
    
    //MARK: Private properties
    private let cellID = "cellID"
    
    let searchController = UISearchController(searchResultsController: nil)
    

    
    //MARK: - SearchController methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        navigationItem.title = "APPstore Search"
        searchController.searchBar.delegate = self
        
        // Register Cell classes
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: cellID)
        
        
        // Setup SearchController
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search the App store for ..."
        searchController.searchBar.becomeFirstResponder()
        searchController.searchBar.scopeButtonTitles = ["All", "Developer", "Software"]
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        
    }

    
    
    //MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CategoryCell
        return cell
    }

}




