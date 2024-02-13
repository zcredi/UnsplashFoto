//
//  FavoritePresenter.swift
//  UnsplashFoto
//
//  Created by Владислав on 12.02.2024.
//

import Foundation

protocol FavoritePresentationLogic {
    func presentFavorites(_ favorites: [FavoriteViewModel])
}

struct FavoriteViewModel {
    let id: String
    let authorName: String
    let imageUrl: String
    let downloads: Int
}

final class FavoritePresenter: FavoritePresentationLogic {
     var viewController: DisplayFavoritesLogic?
    
    func presentFavorites(_ favorites: [FavoriteViewModel]) {
        viewController?.displayFavorites(favorites)
    }
}
