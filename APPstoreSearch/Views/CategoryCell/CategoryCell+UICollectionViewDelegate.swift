//
//  CategoryCell+UICollectionViewDelegate.swift
//  APPstoreSearch
//
//  Created by Hans ter Horst on 31-03-18.
//  Copyright © 2018 Hans ter Horst. All rights reserved.
//

import UIKit

extension CategoryCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let app = categoryItem?.app[indexPath.item] {
            searchResultController.showAppDetailsFor(app: app)
        }
        
        print("Selected: \(indexPath)")
    }
    
}
