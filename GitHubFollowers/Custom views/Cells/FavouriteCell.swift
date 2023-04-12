//
//  FavouriteCell.swift
//  GitHubFollowers
//
//  Created by GO on 4/7/23.
//

import UIKit

class FavouriteCell: UITableViewCell {

    static let reuseId = "FavouriteCell"
    
    let avatarImageView =  GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 26)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func set(favourite: Follower) {
//        usernameLabel.text = favourite.login
//        avatarImageView.downloadImage(from: favourite.avatarUrl)
//    }
    
    func set(favourite: Follower) {
        usernameLabel.text = favourite.login
        NetworkManager.shared.downloadImage(from: favourite.avatarUrl) { [weak self] image in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.avatarImageView.image = image
            }
        }
    }
    
    private func configure() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(usernameLabel)
        
        accessoryType = .disclosureIndicator
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40),
        
        ])
    }
    
}
