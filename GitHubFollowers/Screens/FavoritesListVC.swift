//
//  FavoritesListVC.swift
//  GHFollowers
//
//  Created by Sean Allen on 12/27/19.
//  Copyright © 2019 Sean Allen. All rights reserved.
//

import UIKit

class FavoritesListVC: UIViewController {
    
    let tableView               = UITableView()
    
    var favourites: [Follower]  = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureTableView()
//        getFavourites()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavourites()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.register(FavouriteCell.self, forCellReuseIdentifier: FavouriteCell.reuseId)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func getFavourites() {
        PersistenceManager.retrieveFavourites { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let favourites):
                
                if favourites.isEmpty {
                    self.showEmptyStateView(with: "You have not added any favourite", in: self.view)
                } else {
                    self.favourites = favourites
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
                
            case .failure(let error):
                self.presentGFAlert(title: "Error", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}

extension FavoritesListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favourites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteCell.reuseId, for: indexPath) as! FavouriteCell
        
        let favourite = favourites[indexPath.row]
        
        cell.set(favourite: favourite)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favourite = favourites[indexPath.row]
        let newScreen = FollowersListVC(username: favourite.login)
        navigationController?.pushViewController(newScreen, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        
        let favourite = favourites[indexPath.row]
        favourites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        
        PersistenceManager.updateWith(favourite: favourite, actionType: .remove) { [weak self] error in
            guard let self = self else {return}
            
            guard let error = error else {return}
            
            self.presentGFAlert(title: "Unable to delete", message: error.rawValue, buttonTitle: "Ok")
        }

    }
    
    
}
