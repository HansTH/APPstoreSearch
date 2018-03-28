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
        
        // Add views
        let views = [categoryLabel, appCollectionView, dividerLineView]
        views.forEach({ addSubview($0) } )
    
        
        // Constraints
        categoryLabel.setupConstraintsTo(top: topAnchor, bottom: nil, left: leadingAnchor, right: nil,
                                         margin: .init(top: 0, left: 16, bottom: 0, right: 0))
        
        appCollectionView.setupConstraintsTo(top: categoryLabel.bottomAnchor, bottom: bottomAnchor, left: leadingAnchor, right: trailingAnchor)
        
        dividerLineView.setupConstraintsTo(top: nil, bottom: appCollectionView.bottomAnchor, left: leadingAnchor, right: trailingAnchor,
                                           margin: .init(top: 0, left: 16, bottom: 0, right: 0))
        dividerLineView.sizeConstraints(size: .init(width: 0, height: 1))
        
    }
    
    
    
    //MARK: - UIView objects
    let appCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let categoryLabel: UILabel = {
       let label = UILabel()
        label.text = "Category"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let dividerLineView: UIView = {
        let view  = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    
}




