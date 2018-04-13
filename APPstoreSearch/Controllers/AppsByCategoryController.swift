//
//  AppsByCategoryController.swift
//  APPstoreSearch
//
//  Created by Hans ter Horst on 13-04-18.
//  Copyright © 2018 Hans ter Horst. All rights reserved.
//

import UIKit

class AppsByCategoryController: UITableViewController {
    
    private let cellID = "cellID"
    var apps: [SearchResult]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .always
        guard let items = apps else { return }
        for item in items {
            navigationItem.title = item.genre
        }
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(AppsByCategoryCell.self, forCellReuseIdentifier: cellID)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = apps?.count ?? 0
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! AppsByCategoryCell
        
        guard let item = apps?[indexPath.row] else { return UITableViewCell() }
        cell.textLabel?.text = item.appTitle
        
        return cell
    }
    
}

