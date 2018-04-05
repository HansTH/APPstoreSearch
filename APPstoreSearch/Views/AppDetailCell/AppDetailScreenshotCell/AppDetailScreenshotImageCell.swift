//
//  AppDetailScreenshotImageCell.swift
//  APPstoreSearch
//
//  Created by Hans ter Horst on 04-04-18.
//  Copyright © 2018 Hans ter Horst. All rights reserved.
//

import UIKit

class AppDetailScreenshotImageCell: UICollectionViewCell {
    
    var downloadTask: URLSessionDownloadTask?
    
    var appScreenshot: String? {
        didSet {
            if let urlString = appScreenshot,
                let imageURL = URL(string: urlString){
                downloadTask = screenshotImageView.loadAppImage(with: imageURL)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupSubviewsAndConstraints()
                
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: - Methods
    private func setupSubviewsAndConstraints() {
        
        addSubview(screenshotImageView)
        
        screenshotImageView.setupConstraintsTo(top: topAnchor, bottom: bottomAnchor, left: leadingAnchor, right: trailingAnchor,
                                               margin: .init(top: 8, left: 0, bottom: 8, right: 0))
    }

    
    
    //MARK: - View objects
    let screenshotImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
}
