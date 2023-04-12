//
//  PersistenceManager.swift
//  GitHubFollowers
//
//  Created by GO on 4/7/23.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favourites = "favourites"
    }
    
    static func updateWith(favourite: Follower, actionType: PersistenceActionType, completed: @escaping (GFError?) -> Void) {
        
        retrieveFavourites { result in
            switch result {
            case .success(let favourites):
                var retrieveFavourites = favourites
                
                switch actionType {
                case .add:
                    guard !retrieveFavourites.contains(favourite) else {
                        completed(.alreadyadded)
                        return
                    }
                    
                    retrieveFavourites.append(favourite)
                    
                case .remove:
                    retrieveFavourites.removeAll { $0.login == favourite.login  }
                }
                
                completed(save(favourites: retrieveFavourites))
                
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    
    static func retrieveFavourites(completed: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let favouriteData = defaults.object(forKey: Keys.favourites) as? Data else {
            completed(.success([]))
            
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favourites = try decoder.decode([Follower].self, from: favouriteData)
            completed(.success(favourites))
        } catch {
            completed(.failure(.unableToFavourite))
        }
    }
    
    static func save(favourites: [Follower]) -> GFError? {
        
        do {
            let encoder = JSONEncoder()
            let encodedFavourites = try encoder.encode(favourites)
            defaults.set(encodedFavourites, forKey: Keys.favourites)
            return nil
            
        } catch {
            return .unableToFavourite
        }
    }
}
