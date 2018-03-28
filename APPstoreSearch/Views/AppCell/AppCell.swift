//
//  AppCell.swift
//  APPstoreSearch
//
//  Created by Hans ter Horst on 28-03-18.
//  Copyright © 2018 Hans ter Horst. All rights reserved.
//

import UIKit

class AppCell: UICollectionViewCell {
    
    //MARK: - Private properties
    
    
    
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
        
        backgroundColor = .green
        
    }
    
    
    //MARK: - View objets

    
}



