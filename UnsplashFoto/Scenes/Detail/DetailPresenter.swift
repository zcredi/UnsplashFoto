//
//  DetailPresenter.swift
//  UnsplashFoto
//
//  Created by Владислав on 11.02.2024.
//

import Foundation

struct DetailViewModel {
    let modelId: String
    let name: String
    let profilImage: String
    let imageUrl: String
    let createdAt: String
    let location: String
    let downloads: Int
    let isFavorite: Bool
}

protocol DetailPresentationLogic {
    func presentPhotoDetails(with model: PhotoViewModel, isFavorite: Bool)
    func setPhoto(isFavorite: Bool)
    func showAlert(isFavorite: Bool)
}

final class DetailPresenter: DetailPresentationLogic {
    private var viewModel: DetailViewModel?
    
    weak var view: DetailDisplayLogic?
    
    func setPhoto(isFavorite: Bool) {
        viewModel
            .map { old in
                DetailViewModel(
                    modelId: old.modelId,
                    name: old.name,
                    profilImage: old.profilImage,
                    imageUrl: old.imageUrl,
                    createdAt: old.createdAt,
                    location: old.location,
                    downloads: old.downloads,
                    isFavorite: isFavorite
                )
            }
            .map { view?.displayPhotoDetails($0) }
    }
    
    func presentPhotoDetails(with model: PhotoViewModel, isFavorite: Bool) {
        let viewModel = DetailViewModel(
            modelId: model.id,
            name: model.name,
            profilImage: model.profilImage,
            imageUrl: model.imageUrl,
            createdAt: model.createdAt,
            location: model.location,
            downloads: model.downloads,
            isFavorite: isFavorite
        )
        self.viewModel = viewModel
        view?.displayPhotoDetails(viewModel)
    }
    
    func showAlert(isFavorite: Bool) {
        view?.showAlert(isFavorite: isFavorite)
    }
}
