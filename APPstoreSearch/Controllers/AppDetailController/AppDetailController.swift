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
    private let descriptionCellID = "cellID"
    var appDetails: SearchResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "App details"
        collectionView?.backgroundColor = .white
        
        collectionView?.register(AppDetailDescriptionCell.self, forCellWithReuseIdentifier: descriptionCellID)
        collectionView?.register(AppDetailHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerCellID)
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCellID, for: indexPath) as! AppDetailHeaderCell
        header.appDetails = appDetails
        header.backgroundColor = .white
        
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: descriptionCellID, for: indexPath) as! AppDetailDescriptionCell
            cell.text = appDetails
            return cell
        }
        
        return UICollectionViewCell()
    }
    
}
