//
//  DetailPresenter.swift
//  UnsplashFoto
//
//  Created by Владислав on 11.02.2024.
//

import Foundation

struct DetailViewModel {
    let name: String
    let profilImage: String
    let createdAt: String
    let location: String
    let downloads: Int
}

protocol DetailPresentationLogic {
    func presentPhotoDetails(with photoViewModel: PhotoViewModel)
}

final class DetailPresenter: DetailPresentationLogic {
    weak var viewController: DetailDisplayLogic?

    func presentPhotoDetails(with photoViewModel: PhotoViewModel) {
        let viewModel = DetailViewModel(
            name: photoViewModel.name,
            profilImage: photoViewModel.profilImage,
            createdAt: photoViewModel.createdAt,
            location: photoViewModel.location,
            downloads: photoViewModel.downloads
        )
        viewController?.displayPhotoDetails(viewModel)
    }
}
