//
//  MainInteractor.swift
//  UnsplashFoto
//
//  Created by Владислав on 09.02.2024.
//

import Foundation

protocol MainBusinessLogic {
    func fetchRandomPhotos()
}

final class MainInteractor: MainBusinessLogic {
    var presenter: MainPresentationLogic?
    var worker: MainWorkerProtocol?
    
    func fetchRandomPhotos() {
        worker?.fetchRandomPhotos { [weak self] result in
            switch result {
            case .success(let photos):
                print("Успешно получены фотографии: \(photos.count)")
                self?.presenter?.presentFetchedPhotos(photos)
            case .failure(let error):
                print("Ошибка при получении фотографий: \(error)")
            }
        }
    }
}
