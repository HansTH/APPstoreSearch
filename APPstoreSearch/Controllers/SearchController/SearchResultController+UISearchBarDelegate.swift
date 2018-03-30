//
//  SearchController+.swift
//  APPstoreSearch
//
//  Created by Hans ter Horst on 28-03-18.
//  Copyright © 2018 Hans ter Horst. All rights reserved.
//

import UIKit

extension SearchResultController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        performSearch()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        performSearch()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search.dataTask?.cancel()
        search.searchResults.removeAll()
        search.hasSearched = false
        search.isLoading = false
        collectionView?.reloadData()
    }
}
