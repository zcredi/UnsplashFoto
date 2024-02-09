//
//  MainPresenter.swift
//  UnsplashFoto
//
//  Created by Владислав on 09.02.2024.
//

import Foundation

protocol MainPresentationLogic {
    func presentFetchedPhotos(_ photos: [UnsplashPhotoModel])
}

final class MainPresenter: MainPresentationLogic {
    weak var viewController: MainDisplayLogic?

    func presentFetchedPhotos(_ photos: [UnsplashPhotoModel]) {
        
    }
}
