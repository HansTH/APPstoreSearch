//
//  AppDetailDescriptionCell.swift
//  APPstoreSearch
//
//  Created by Hans ter Horst on 03-04-18.
//  Copyright © 2018 Hans ter Horst. All rights reserved.
//

import UIKit

class AppDetailDescriptionCell: UICollectionViewCell {
    
    var text: SearchResult? {
        didSet {
            guard let description = text else { return }
            descriptionTextView.text = description.description
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviewsAndConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupSubviewsAndConstraints() {
        
        let views = [titleLabel, descriptionTextView]
        views.forEach({addSubview($0)})
        
        titleLabel.setupConstraintsTo(top: topAnchor, bottom: nil, left: leadingAnchor, right: trailingAnchor,
                                      margin: .init(top: 8, left: 16, bottom: 0, right: 16))
        titleLabel.sizeConstraints(size: .init(width: 0, height: 22))
        descriptionTextView.setupConstraintsTo(top: titleLabel.bottomAnchor, bottom: bottomAnchor, left: leadingAnchor, right: trailingAnchor,
                                         margin: .init(top: 0, left: 16, bottom: 16, right: 16))
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Description:"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .gray
        textView.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return textView
    }()
}

