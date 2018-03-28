//
//  SearchController+.swift
//  APPstoreSearch
//
//  Created by Hans ter Horst on 28-03-18.
//  Copyright © 2018 Hans ter Horst. All rights reserved.
//

import UIKit

extension SearchController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        print(searchBar.text!)
    }
}
