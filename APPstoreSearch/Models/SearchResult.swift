//
//  SearchResult.swift
//  APPstoreSearch
//
//  Created by Hans ter Horst on 29-03-18.
//  Copyright © 2018 Hans ter Horst. All rights reserved.
//

import Foundation

class SearchResult: Codable {
    var appTitle: String?
    var developer: String?
    var price: Double?
    var currency: String?
    var imageSmall: String?
    var imageLarge: String?
    var storeURL: String?
    var genre: String?
    
    enum CodingKeys: String, CodingKey {
        case imageSmall = "artworkUrl60"
        case imageLarge = "artworkUrl100"
        case storeURL = "trackViewUrl"
        case genre = "primaryGenreName"
        case developer = "artistName"
        case appTitle = "trackName"
//        case itemPrice = "trackPrice"
        case currency, price
    
    }
    
    var name: String {
        return appTitle ?? ""
    }
    
    var appPrice: String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency
        var currentPrice: String?
        let somePrice = price ?? 0
        if somePrice == 0 {
            currentPrice = "Free"
        } else {
            currentPrice = formatter.string(from: somePrice as NSNumber)
        }
        return currentPrice
    }
}

extension SearchResult: CustomStringConvertible {
    
    var description: String {
        return "Name: \(name), Artist name: \(developer ?? ""), Price: \(appPrice ?? "Free")\n"
    }
}