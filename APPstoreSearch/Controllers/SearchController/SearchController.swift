//
//  SearchController.swift
//  APPstoreSearch
//
//  Created by Hans ter Horst on 28-03-18.
//  Copyright © 2018 Hans ter Horst. All rights reserved.
//

import UIKit

class SearchController: UICollectionViewController {
    
    //MARK: Private properties
    private let cellID = "cellID"
    

    
    //MARK: - SearchController methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .red
        
        // Register Cell classes
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: cellID)
        
    }

    
    
    //MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CategoryCell
        return cell
    }

}




