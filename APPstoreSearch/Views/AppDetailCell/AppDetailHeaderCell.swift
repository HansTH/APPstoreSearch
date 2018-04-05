//
//  AppDetailHeaderCell.swift
//  APPstoreSearch
//
//  Created by Hans ter Horst on 03-04-18.
//  Copyright © 2018 Hans ter Horst. All rights reserved.
//

import UIKit

class AppDetailHeaderCell: UICollectionViewCell {
    
    //MARK: - Properties
    var downloadTask: URLSessionDownloadTask?
    
    var appDetails: SearchResult? {
        didSet {
            guard let detail = appDetails else { return }
            
            appTitle.text = detail.appTitle
            
            developer.text = detail.developer
            
            appPriceButton.setTitle(detail.appPrice, for: .normal)
            
            if let imageString = detail.imageLarge,
                let imageURL = URL(string: imageString){
                downloadTask = appImageView.loadAppImage(with: imageURL)
            } else {
                appImageView.image = UIImage(named: "splitAmount")
            }
        }
    }
    
    
    //MARK: - AppDetailHeaderCell methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviewsAndConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Methods
    private func setupSubviewsAndConstraints() {
        
        let views = [appImageView, appTitle, developer, appPriceButton, dividerLineView]
        views.forEach({addSubview($0)})
        
        appImageView.setupConstraintsTo(top: topAnchor, bottom: nil, left: leadingAnchor, right: nil,
                                        margin: .init(top: 16, left: 16, bottom: 0, right: 0))
        appImageView.sizeConstraints(size: .init(width: 100, height: 100))
        
        appTitle.setupConstraintsTo(top: appImageView.topAnchor, bottom: nil, left: appImageView.trailingAnchor, right: trailingAnchor,
                                    margin: .init(top: 0, left: 8, bottom: 0, right: 16))
        
        developer.setupConstraintsTo(top: appTitle.bottomAnchor, bottom: nil, left: appImageView.trailingAnchor, right: trailingAnchor,
                                     margin: .init(top: 0, left: 8, bottom: 0, right: 16))
        
        appPriceButton.setupConstraintsTo(top: nil, bottom: appImageView.bottomAnchor, left: appImageView.trailingAnchor, right: nil,
                                          margin: .init(top: 0, left: 8, bottom: 0, right: 0))
        appPriceButton.sizeConstraints(size: .init(width: 80, height: 26))
        
        dividerLineView.setupConstraintsTo(top: nil, bottom: bottomAnchor, left: leadingAnchor, right: trailingAnchor)
        dividerLineView.sizeConstraints(size: .init(width: frame.width, height: 0.5))
    }
    
    
    //MARK: - View objects
    let appImageView: UIImageView = {
        let image = UIImage(named: "splitAmount")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let appTitle: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    let developer: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    let appPriceButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 13
        button.clipsToBounds = true
        return button
    }()
    
    let dividerLineView: UIView = {
        let view  = UIView()
        view.backgroundColor = .gray
        return view
    }()
}
