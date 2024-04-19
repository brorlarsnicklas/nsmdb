//
//  PersistenceManager.swift
//  nsmdb
//
//  Created by Nicklas Silversved on 2024-04-19.
//

import Foundation


enum PersistenceActionType {
    case add, remove, update
}

class PersistenceManager {
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let ratings = "ratings"
    }
    
    static func updateRatings(item: SearchItem, actionType: PersistenceActionType, completed: @escaping (NSMDBError?) -> Void) {
        getRatings { result in
            switch result {
            case .success(let ratings):
                var fetchedRatings = ratings
                
                switch actionType {
                case .add:
                    guard !fetchedRatings.contains(where: { $0.id == item.id }) else {
                        completed(.ratingAlreadyStored)
                        return
                    }
                    fetchedRatings.append(item)
                case .remove:
                    fetchedRatings.removeAll(where: { $0.id == item.id })
                    return
                case .update:
                    if let ratingIndex = fetchedRatings.firstIndex(where: { $0.id == item.id }) {
                        fetchedRatings[ratingIndex].userRating = item.userRating
                    } else {
                        completed(.unableToComplete)
                        return
                    }
                }
                
                completed(storeRatings(ratings: fetchedRatings))
            case .failure(let error):
                completed(error)
            }
        }

    }
    
    
    static func getRatings(completed: @escaping (Result<[SearchItem], NSMDBError>) -> Void) {
        guard let ratingsData = defaults.object(forKey: Keys.ratings) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let ratings = try decoder.decode([SearchItem].self, from: ratingsData)
            completed(.success(ratings))
        } catch {
            completed(.failure(.unableToFetchFromStorage))
        }
    }
    
    static func storeRatings(ratings: [SearchItem]) -> NSMDBError? {
        do {
            let encoder = JSONEncoder()
            let encodedItems = try encoder.encode(ratings)
            defaults.set(encodedItems, forKey: Keys.ratings)
            return nil
        } catch {
            return .unableToStoreRatings
        }
    }
    
}
