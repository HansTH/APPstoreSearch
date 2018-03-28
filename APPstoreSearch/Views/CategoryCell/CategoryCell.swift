//
//  CategoryCell.swift
//  APPstoreSearch
//
//  Created by Hans ter Horst on 28-03-18.
//  Copyright © 2018 Hans ter Horst. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    //MARK: - Properties
    let appCellID = "appCellID"
    
    
    
    //MARK: - CategoryCell methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Delegates
        appCollectionView.delegate = self
        appCollectionView.dataSource = self
        
        //register cell
        appCollectionView.register(AppCell.self, forCellWithReuseIdentifier: appCellID)
        
        setupSubviewsAndConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: - Private methods
    private func setupSubviewsAndConstraints() {
        
        backgroundColor = .yellow
 
        addSubview(appCollectionView)
    
        appCollectionView.pinEdges(to: self, with: .zero)
        
    }
    
    
    
    //MARK: - View objects
    let appCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .blue
        return collectionView
    }()
    
    
}




