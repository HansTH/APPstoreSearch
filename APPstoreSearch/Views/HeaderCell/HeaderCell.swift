//
//  HeaderCell.swift
//  APPstoreSearch
//
//  Created by Hans ter Horst on 30-03-18.
//  Copyright © 2018 Hans ter Horst. All rights reserved.
//

import UIKit

class HeaderCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviewsAndConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupSubviewsAndConstraints() {
        
        let views = [loadingIndicator, textLabel]
        views.forEach( { addSubview($0) } )
        
        loadingIndicator.setupConstraintsTo(top: nil, bottom: textLabel.topAnchor, left: leadingAnchor, right: trailingAnchor)
        textLabel.centerConstraints(to: self)
    }
    
    let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.activityIndicatorViewStyle = .gray
        return indicator
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
}
