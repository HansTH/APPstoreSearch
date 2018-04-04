//
//  AppDetailScreenshotCell+UICollectionViewDataSource.swift
//  APPstoreSearch
//
//  Created by Hans ter Horst on 04-04-18.
//  Copyright © 2018 Hans ter Horst. All rights reserved.
//

import UIKit

extension AppDetailScreenshotCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: screenshotImageCellID, for: indexPath) as! AppDetailScreenshotImageCell
        return cell
    }
    
}
