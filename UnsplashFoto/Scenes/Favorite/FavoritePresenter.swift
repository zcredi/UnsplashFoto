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
    let profilImage: String
    let createdAt: String
    let location: String
}

final class FavoritePresenter: FavoritePresentationLogic {
    var viewController: DisplayFavoritesLogic?
    private var viewModel: FavoriteViewModel?
    
    func presentFavorites(_ favorites: [FavoriteViewModel]) {
        viewController?.displayFavorites(favorites)
    }
}
