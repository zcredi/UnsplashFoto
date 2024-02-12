//
//  MainPresenter.swift
//  UnsplashFoto
//
//  Created by Владислав on 09.02.2024.
//

import Foundation

protocol MainPresentationLogic {
    func presentFetchedPhotos(_ photos: [UnsplashPhoto])
}

struct PhotoViewModel {
    let imageUrl: String
    let profilImage: String
    let name: String
    let createdAt: String
    let location: String
    let downloads: Int
}

final class MainPresenter: MainPresentationLogic {
    weak var viewController: MainDisplayLogic?
    
    func presentFetchedPhotos(_ photos: [UnsplashPhoto]) {
        let viewModels = photos.compactMap { photo -> PhotoViewModel? in
            guard let thumbURL = photo.urls?.thumb else { return nil }
            
            return PhotoViewModel(
                imageUrl: thumbURL,
                profilImage: photo.user.profile_image.large,
                name: photo.user.name,
                createdAt: photo.createdAt ?? "",
                location: photo.location?.city ?? "",
                downloads: photo.downloads ?? 0
            )
        }
        viewController?.displayFetchedPhotos(viewModels)
    }
}
