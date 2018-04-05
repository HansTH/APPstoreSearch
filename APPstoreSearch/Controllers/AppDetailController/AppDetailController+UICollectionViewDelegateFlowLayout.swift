//
//  AppDetailController+Header.swift
//  APPstoreSearch
//
//  Created by Hans ter Horst on 03-04-18.
//  Copyright © 2018 Hans ter Horst. All rights reserved.
//

import UIKit

extension AppDetailController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.item {
        case 0:
            return CGSize(width: view.frame.width, height: 200)
        case 1:
            return CGSize(width: view.frame.width, height: 400)
        case 2:
            return CGSize(width: view.frame.width, height: 140)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 132)
    }
    
}
