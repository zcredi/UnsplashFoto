//
//  FavoritesManager.swift
//  UnsplashFoto
//
//  Created by Владислав on 13.02.2024.
//

import Foundation

class FavoritesManager {
    static let shared = FavoritesManager()
    private let favoritesKey = "favorites"

    private init() {}

    func addFavorite(photo: FavoritePhoto) {
        var favorites = getFavorites()
        if !favorites.contains(where: { $0.id == photo.id }) {
            favorites.append(photo)
            save(favorites: favorites)
            print("Added favorite: \(photo)")
        }
    }

    func removeFavorite(photoId: String) {
        var favorites = getFavorites()
        favorites.removeAll { $0.id == photoId }
        save(favorites: favorites)
    }

    func getFavorites() -> [FavoritePhoto] {
        guard let data = UserDefaults.standard.data(forKey: favoritesKey),
              let favorites = try? JSONDecoder().decode([FavoritePhoto].self, from: data) else {
            print("No favorites found")
            return []
        }
        print("Found favorites: \(favorites)")
        return favorites
    }

    private func save(favorites: [FavoritePhoto]) {
        do {
            let data = try JSONEncoder().encode(favorites)
            UserDefaults.standard.set(data, forKey: favoritesKey)
            print("Favorites saved successfully")
        } catch {
            print("Failed to encode favorites: \(error)")
        }
    }
}
