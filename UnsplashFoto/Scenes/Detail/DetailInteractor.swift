//
//  DetailInteractor.swift
//  UnsplashFoto
//
//  Created by Владислав on 12.02.2024.
//

import Foundation

protocol DetailBusinessLogic {
    func handleFavoriteButtonTap(photoViewModel: UnsplashPhoto)
}

final class DetailInteractor: DetailBusinessLogic {
    var presenter: DetailPresentationLogic?
    
    func handleFavoriteButtonTap(photoViewModel: UnsplashPhoto) {
        let favoritePhoto = FavoritePhoto(id: photoViewModel.id, imageUrl: photoViewModel.user.profile_image.small, authorName: photoViewModel.user.name, downloadCount: photoViewModel.downloads)
        
        if FavoritesManager.shared.getFavorites().contains(where: { $0.id == photoViewModel.id }) {
            FavoritesManager.shared.removeFavorite(photoId: photoViewModel.id ?? "")
        } else {
            FavoritesManager.shared.addFavorite(photo: favoritePhoto)
        }
    }
}
