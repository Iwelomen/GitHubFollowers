//
//  ErrorMessage.swift
//  GitHubFollowers
//
//  Created by GO on 4/4/23.
//

import Foundation

enum GFError: String, Error {
    case invalidUrl = "Invalid url"
    case unableToComplete = "Unable to complete request, Check Internet"
    case invalidResponseFormat = "Invalid response format"
    case invalidDataResponse = "Inavalid data response"
    case unableToFavourite = "There was an error favouriting this user"
    case alreadyadded = "Already in favourite list"
}
