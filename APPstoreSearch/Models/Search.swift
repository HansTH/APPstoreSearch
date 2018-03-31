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
    
    var dataTask: URLSessionTask?
    var state: State = .notSearchedYet
    
    enum State {
        case notSearchedYet, loading, noResults
        case results([AppCategory])
    }
    
    enum Category: Int {
        case all = 0
        case iOS = 1
        case iPad = 2
        case mac = 3
        case developer = 4
        
        var type: String {
            switch self {
            case .all:
                return "&media=software"
            case .iOS:
                return "&media=software&entity=software"
            case .iPad:
                return "&media=software&entity=iPadSoftware"
            case .mac:
                return "&media=software&entity=macSoftware"
            case .developer:
                return "&media=software&attribute=softwareDeveloper"
            }
        }
    }
    
    func performSearch(with searchText: String, category: Category, completion: @escaping SearchComplete) {
        
        if !searchText.isEmpty {
            dataTask?.cancel()
            state = .loading
            
            let url = self.iTunesURL(searchText: searchText, category: category)
            
            let session = URLSession.shared
            
            dataTask = session.dataTask(with: url, completionHandler: { (data, response, error) in
                
                var newState = State.notSearchedYet
                var success = false
                
                if let error = error as NSError?, error.code == -999 {
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data {
                    
                    var searchResults = self.parse(data: data)
                    if searchResults.isEmpty {
                        newState = .noResults
                    } else {
                        searchResults.sort { $0.category! < $1.category! }
                        newState = .results(searchResults)
                    }
                    success = true
                }
                
                DispatchQueue.main.async {
                    self.state = newState
                    completion(success)
                }
            })
            dataTask?.resume()
        }
    }
    
    
    //MARK: - Network
    private func iTunesURL(searchText: String, category: Category) -> URL {
        
        let countryCode = NSLocale.current.regionCode!
        let text = searchText.lowercased()
        let encodedText = text.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let urlString = "https://itunes.apple.com/search?term=\(encodedText)&country=\(countryCode)\(category.type)&limit=200"
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
