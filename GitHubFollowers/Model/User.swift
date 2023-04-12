//
//  User.swift
//  GitHubFollowers
//
//  Created by GO on 4/4/23.
//

import Foundation

struct User: Codable {
    var login: String
    var htmlUrl: String
    var avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var followers: Int
    var following: Int
    var createdAt: Date
}
