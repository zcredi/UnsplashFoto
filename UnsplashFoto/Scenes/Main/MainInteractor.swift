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
                   // Здесь можно передать данные в Presenter
                   self?.presenter?.presentFetchedPhotos(photos)
               case .failure(let error):
                   // Обработка ошибки
                   print(error)
               }
           }
       }
}
