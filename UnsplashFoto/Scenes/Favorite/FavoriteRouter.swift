//
//  FavoriteRouter.swift
//  UnsplashFoto
//
//  Created by Владислав on 14.02.2024.
//


import UIKit

protocol FavoriteRoutingLogic {
    func routeToDetail(with favoriteViewModel: FavoriteViewModel)
}

final class FavoriteRouter: NSObject, FavoriteRoutingLogic {

    private let factory: SceneFactory
    weak var viewController: FavoriteViewController?

    init(factory: SceneFactory) {
        self.factory = factory
    }

    func routeToDetail(with favoriteViewModel: FavoriteViewModel) {
        // Преобразуйте FavoriteViewModel в PhotoViewModel
        let photoViewModel = PhotoViewModel(
            id: favoriteViewModel.id,
            imageUrl: favoriteViewModel.imageUrl,
            profilImage: favoriteViewModel.profilImage,
            name: favoriteViewModel.authorName,
            createdAt: favoriteViewModel.createdAt,
            location: favoriteViewModel.location,
            downloads: favoriteViewModel.downloads
        )

        let detailVC = factory.makeDetailScene(model: photoViewModel, router: self)
        viewController?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
