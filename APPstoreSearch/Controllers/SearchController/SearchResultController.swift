//
//  SearchResultController.swift
//  APPstoreSearch
//
//  Created by Hans ter Horst on 28-03-18.
//  Copyright © 2018 Hans ter Horst. All rights reserved.
//

import UIKit

class SearchResultController: UICollectionViewController {
    
    //MARK: Private properties
    private let cellID = "cellID"
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var searchResults = [AppCategory]()
    var dataTask: URLSessionDataTask?
    var downloadTask: URLSessionDownloadTask?
    var hasSearched = false
    var isLoading = false
    

    
    //MARK: - SearchResultController methods
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
        searchController.searchBar.scopeButtonTitles = ["All", "iOS", "iPad", "Mac", "Developer"]
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        
    }

    
    
    //MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CategoryCell
        
        let item = searchResults[indexPath.item]
        cell.categoryItem = item
        return cell
    }
    
    
    
    //MARK: - Network
    func iTunesURL(searchText: String, segment: Int) -> URL {

        var searchRequest = ""
        switch segment {
        case 1:
            searchRequest = "&media=software&entity=software"
        case 2:
            searchRequest = "&media=software&entity=iPadSoftware"
        case 3:
            searchRequest = "&media=software&entity=macSoftware"
        case 4:
            searchRequest = "&media=software&attribute=softwareDeveloper"
        default:
            searchRequest = "&media=software"
        }
        
        let countryCode = NSLocale.current.regionCode!
        let text = searchText.lowercased()
        let encodedText = text.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let urlString = "https://itunes.apple.com/search?term=\(encodedText)&country=\(countryCode)\(searchRequest)&limit=200"
        let url = URL(string: urlString)
        print(url!)
        return url!
    }
    
    func performSearchRequest(with url: URL) -> Data? {
        
        do {
            return try Data(contentsOf: url)
        } catch {
            showNetworkError()
            print("Download error: \(error.localizedDescription)")
            return nil
        }
    }
    
    func parse(data: Data) -> [AppCategory] {
        do {
            let decoder = JSONDecoder()
            let jsonResult = try decoder.decode(Result.self, from: data).results
            
            let groupedDictionay = Dictionary(grouping: jsonResult, by: { (app) -> String in
                return app.genre!
            })
            
            var appCategory = [AppCategory]()
            groupedDictionay.forEach({(category) in
                let app = AppCategory()
                app.category = category.key
                app.app.append(contentsOf: category.value)
                appCategory.append(app)
            })
            return appCategory
            
        } catch {
            print("JSON decoder error: \(error)")
            return []
        }
    }
    
    func performSearch(_ searchBar: UISearchBar) {
        
        self.hasSearched = false
        
        if !searchBar.text!.isEmpty {
            searchBar.resignFirstResponder()
            hasSearched = true
            dataTask?.cancel()
            isLoading = true
            searchResults.removeAll()
            collectionView?.reloadData()
            
            let url = self.iTunesURL(searchText: searchBar.text!, segment: searchBar.selectedScopeButtonIndex)
            
            let session = URLSession.shared
            
            dataTask = session.dataTask(with: url, completionHandler: { (data, response, error) in
                if let error = error as NSError?, error.code == -999 {
                    return //-999 when cancel the search
                } else if let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 {
                    
                    if let data = data {
                        
                        self.searchResults = self.parse(data: data)
                        self.searchResults.sort {$0.category! < $1.category!}
                        
                        DispatchQueue.main.async {
                            self.isLoading = false
                            self.collectionView?.reloadData()
                        }
                        return
                    }
                } else {
                    if let response = response {
                        print("Failure: \(response)")
                    }
                }
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.hasSearched = false
                    self.collectionView?.reloadData()
                }
            })
            dataTask?.resume()
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




