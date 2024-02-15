//
//  PersistenceManager.swift
//  UnsplashFoto
//
//  Created by Владислав on 13.02.2024.
//

import Foundation

protocol PersistenceManager: AnyObject {
    func favorites() -> [String]?
    @discardableResult
    func saveToFavorites(id: String) -> String?
    @discardableResult
    func removeFromFavorites(id: String) -> String?
}

final class PersistenceManagerImpl: PersistenceManager {
    private let favoritesKey = "favoritesKey"
    private let userDefaults: UserDefaults
    
    //MARK: - init(_:)
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func favorites() -> [String]? {
        userDefaults.stringArray(forKey: favoritesKey)
    }
    
    @discardableResult
    func saveToFavorites(id: String) -> String? {
        guard var favorites = userDefaults.stringArray(forKey: favoritesKey) else {
            var favorites = [String]()
            favorites.append(id)
            userDefaults.setValue(favorites, forKey: favoritesKey)
            return id
        }
        if favorites.contains(id) == true { return nil }
        favorites.append(id)
        userDefaults.setValue(favorites, forKey: favoritesKey)
        return id
    }
    
    @discardableResult
    func removeFromFavorites(id: String) -> String? {
        guard var favorites = userDefaults.stringArray(forKey: favoritesKey) else {
            return id
        }
        guard let index = favorites.firstIndex(of: id) else { return nil }
        defer { userDefaults.setValue(favorites, forKey: favoritesKey) }
        return favorites.remove(at: index)
    }
    
}
