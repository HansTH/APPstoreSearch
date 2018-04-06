//
//  AppCell.swift
//  APPstoreSearch
//
//  Created by Hans ter Horst on 28-03-18.
//  Copyright © 2018 Hans ter Horst. All rights reserved.
//

import UIKit

class AppCell: UICollectionViewCell {
    
    //MARK: - Properties
    var downloadTask: URLSessionDownloadTask?
    
    var app: SearchResult? {
        didSet {
            guard let app = app else { return }
            appTitleLabel.text = app.appTitle
            developerLabel.text = app.developer
            
            priceLabel.text = app.appPrice
            
            appImageView.image = UIImage(named: "Placeholder")
            if let urlString = app.imageLarge,
                let imageURL = URL(string: urlString){
                downloadTask = appImageView.loadAppImage(with: imageURL)
            }
        }
    }
    
    
    //MARK: - AppCell methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviewsAndConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Private methods
    private func setupSubviewsAndConstraints() {
        
        
        // Add Views
        let views = [appImageView, appTitleLabel, developerLabel, priceLabel]
        views.forEach( { addSubview($0)} )
        
        
        // Constraints
        appImageView.setupConstraintsTo(top: topAnchor, bottom: nil, left: leadingAnchor, right: nil,
                                        margin: .init(top: 4, left: 0, bottom: 0, right: 0))
        appImageView.sizeConstraints(size: .init(width: frame.width, height: frame.width))
        
        appTitleLabel.setupConstraintsTo(top: appImageView.bottomAnchor, bottom: nil, left: leadingAnchor, right: trailingAnchor,
                                        margin: .init(top: 8, left: 0, bottom: 0, right: 0))
        
        developerLabel.setupConstraintsTo(top: appTitleLabel.bottomAnchor, bottom: nil, left: leadingAnchor, right: trailingAnchor,
                                        margin: .init(top: 8, left: 0, bottom: 0, right: 0))
        
        priceLabel.setupConstraintsTo(top: developerLabel.bottomAnchor, bottom: nil, left: leadingAnchor, right: trailingAnchor,
                                              margin: .init(top: 8, left: 0, bottom: 0, right: 0))
   
    }
    
    
    //MARK: - UIView objets
    let appImageView: UIImageView = {
        let image = UIImage(named: "Placeholder")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let appTitleLabel: UILabel = {
       let label = UILabel()
        label.text = "Split Amount"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    let developerLabel: UILabel = {
        let label = UILabel()
        label.text = "Hans ter Horst"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "€0,99"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        return label
    }()
    

    
}



