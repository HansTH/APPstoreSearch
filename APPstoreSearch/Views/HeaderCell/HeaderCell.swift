//
//  HeaderCell.swift
//  APPstoreSearch
//
//  Created by Hans ter Horst on 30-03-18.
//  Copyright © 2018 Hans ter Horst. All rights reserved.
//

import UIKit

class HeaderCell: UICollectionViewCell {
    
    //MARK: - HeaderCell methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviewsAndConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Private methods
    private func setupSubviewsAndConstraints() {
        
        let views = [loadingIndicator, titleLabel, textLabel]
        views.forEach( { addSubview($0) } )
        
        loadingIndicator.setupConstraintsTo(top: nil, bottom: titleLabel.topAnchor, left: leadingAnchor, right: trailingAnchor)
        titleLabel.centerConstraints(to: self)
        textLabel.setupConstraintsTo(top: nil, bottom: bottomAnchor, left: leadingAnchor, right: trailingAnchor)
    }
    
    
    //MARK: - View objects
    let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.activityIndicatorViewStyle = .gray
        return indicator
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
}
