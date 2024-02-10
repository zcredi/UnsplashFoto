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
    let url: String
}

final class MainPresenter: MainPresentationLogic {
    weak var viewController: MainDisplayLogic?
    
    func presentFetchedPhotos(_ photos: [UnsplashPhoto]) {
        let viewModels = photos.map { photo -> PhotoViewModel in
            print("URL: \(photo.urls.small)")
            return PhotoViewModel(url: photo.urls.thumb)
        }
        viewController?.displayFetchedPhotos(viewModels)
    }
}
