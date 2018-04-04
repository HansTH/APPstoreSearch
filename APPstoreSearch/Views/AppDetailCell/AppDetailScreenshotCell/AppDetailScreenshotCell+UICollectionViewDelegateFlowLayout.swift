//
//  AppDetailScreenshotImageCell+UICollectionViewDelegateFlowLayout.swift
//  APPstoreSearch
//
//  Created by Hans ter Horst on 04-04-18.
//  Copyright © 2018 Hans ter Horst. All rights reserved.
//

import UIKit

extension AppDetailScreenshotCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 200, height: 400 - titleLabel.frame.height)
    }
    
    // Margin to the begin and end of the collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
}
