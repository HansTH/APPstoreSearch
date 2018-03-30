//
//  Search.swift
//  APPstoreSearch
//
//  Created by Hans ter Horst on 30-03-18.
//  Copyright © 2018 Hans ter Horst. All rights reserved.
//

import Foundation

typealias SearchComplete = (Bool) -> Void

class Search {
    var searchResults = [AppCategory]()
    var hasSearched = false
    var isLoading = false
    
    var dataTask: URLSessionTask?
    
    func performSearch(with searchText: String, category: Int,
                       completion: @escaping SearchComplete) {
        
        if !searchText.isEmpty {
            dataTask?.cancel()
            isLoading = true
            hasSearched = true
            searchResults.removeAll()
            
            let url = self.iTunesURL(searchText: searchText, segment: category)
            
            let session = URLSession.shared
            
            dataTask = session.dataTask(with: url, completionHandler: { (data, response, error) in
                var success = false
                if let error = error as NSError?, error.code == -999 {
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data {
                    
                    self.searchResults = self.parse(data: data)
                    self.searchResults.sort { $0.category! < $1.category! }
                    
                    self.isLoading = false
                    print("Success")
                    success = true
                }
                
                if !success {
                    print("Failure: \(response!)")
                    self.hasSearched = false
                    self.isLoading = false
                }
                
                DispatchQueue.main.async {
                    completion(success)
                }
            })
            dataTask?.resume()
        }
    }
    
    
    //MARK: - Network
    private func iTunesURL(searchText: String, segment: Int) -> URL {
        
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
        return url!
    }
    
    private func parse(data: Data) -> [AppCategory] {
        do {
            let decoder = JSONDecoder()
            let jsonResult = try decoder.decode(Result.self, from: data).results
            
            let groupedDictionay = Dictionary(grouping: jsonResult, by: { (result) -> String in
                return result.genre!
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
    
}
