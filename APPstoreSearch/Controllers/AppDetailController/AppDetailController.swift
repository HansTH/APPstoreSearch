//
//  AppDetailController.swift
//  APPstoreSearch
//
//  Created by Hans ter Horst on 03-04-18.
//  Copyright © 2018 Hans ter Horst. All rights reserved.
//

import UIKit

class AppDetailController: UICollectionViewController {
    
    //MARK: - Properties
    private let headerCellID = "headerCellID"
    private let descriptionCellID = "cellID"
    private let screenshotCellID = "screenshotCellID"
    private let infoCellID = "infoCellID"
    
    var appDetails: SearchResult?
    
    
    //MARK: - AppDetailController methods
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "App details"
        collectionView?.backgroundColor = .white
        
        collectionView?.register(AppDetailDescriptionCell.self, forCellWithReuseIdentifier: descriptionCellID)
        collectionView?.register(AppDetailScreenshotCell.self, forCellWithReuseIdentifier: screenshotCellID)
        collectionView?.register(AppDetailInfoCell.self, forCellWithReuseIdentifier: infoCellID)
        collectionView?.register(AppDetailHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerCellID)
    }

    
    //MARK: - UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCellID, for: indexPath) as! AppDetailHeaderCell
        header.appDetails = appDetails
        
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: descriptionCellID, for: indexPath) as! AppDetailDescriptionCell
            cell.text = appDetails
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: screenshotCellID, for: indexPath) as! AppDetailScreenshotCell
            if let screenshot = appDetails?.screenshotUrls {
                cell.appScreenshotUrls = screenshot
            }
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: infoCellID, for: indexPath) as! AppDetailInfoCell
            cell.info = appDetails
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
}
