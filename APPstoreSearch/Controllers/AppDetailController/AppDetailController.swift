//
//  AppDetailController.swift
//  APPstoreSearch
//
//  Created by Hans ter Horst on 03-04-18.
//  Copyright © 2018 Hans ter Horst. All rights reserved.
//

import UIKit

class AppDetailController: UICollectionViewController {
    
    private let headerCellID = "headerCellID"
    private let cellID = "cellID"
    var appDetails: SearchResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "App details"
        collectionView?.backgroundColor = .white
        
        collectionView?.register(AppDetailHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerCellID)
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCellID, for: indexPath) as! AppDetailHeaderCell
        header.appDetails = appDetails
        header.backgroundColor = .white
        
        return header
    }
    
    
}
