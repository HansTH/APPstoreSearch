//
//  AppDetailScreenshotCell.swift
//  APPstoreSearch
//
//  Created by Hans ter Horst on 04-04-18.
//  Copyright © 2018 Hans ter Horst. All rights reserved.
//

import UIKit

class AppDetailScreenshotCell: UICollectionViewCell {
    
    //MARK: - Properties
    let screenshotImageCellID = "screenshotImageCellID"
    var appScreenshotUrls: [String]?
    
    
    //MARK: - AppDetailScreenshotCell methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        screenshotCollectionView.dataSource = self
        screenshotCollectionView.delegate = self
        
        screenshotCollectionView.register(AppDetailScreenshotImageCell.self, forCellWithReuseIdentifier: screenshotImageCellID)
        
        setupSubviewsAndConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Methods
    private func setupSubviewsAndConstraints() {
        
        let views = [titleLabel, screenshotCollectionView, dividerLineView]
        views.forEach({addSubview($0)})
        
        titleLabel.setupConstraintsTo(top: topAnchor, bottom: nil, left: leadingAnchor, right: trailingAnchor,
                                      margin: .init(top: 0, left: 16, bottom: 0, right: 0))
        
        screenshotCollectionView.setupConstraintsTo(top: titleLabel.bottomAnchor, bottom: bottomAnchor,
                                                    left: leadingAnchor, right: trailingAnchor)
        
        dividerLineView.setupConstraintsTo(top: nil, bottom: bottomAnchor, left: leadingAnchor, right: trailingAnchor,
                                      margin: .init(top: 0, left: 16, bottom: 0, right: 0))
        dividerLineView.sizeConstraints(size: .init(width: 0, height: 0.5))
    }
    
    
    
    //MARK: - View objects
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Screenshots"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    let screenshotCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let dividerLineView: UIView = {
        let view  = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
}


