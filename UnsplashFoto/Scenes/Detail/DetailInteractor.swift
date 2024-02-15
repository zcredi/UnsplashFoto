//
//  DetailInteractor.swift
//  UnsplashFoto
//
//  Created by Владислав on 12.02.2024.
//

import Foundation

protocol DetailBusinessLogic {
    func viewDidLoad()
    func didTapFavoriteButton(_ id: String, isAddingToFavorites: Bool)
}

final class DetailInteractor: DetailBusinessLogic {
    private let persistenceManager: PersistenceManager
    private let presenter: DetailPresentationLogic
    private var model: PhotoViewModel
    
    //MARK: - init(_:)
    init(
        presenter: DetailPresentationLogic,
        persistenceManager: PersistenceManager,
        model: PhotoViewModel
    ) {
        self.persistenceManager = persistenceManager
        self.presenter = presenter
        self.model = model
    }
    
    //MARK: - Methods Lifecycle
    func viewDidLoad() {
        self.presenter.presentPhotoDetails(
            with: model,
            isFavorite: persistenceManager.favorites()?.contains(model.id) ?? false
        )
    }
    
    func didTapFavoriteButton(_ id: String, isAddingToFavorites: Bool) {
        if persistenceManager.favorites()?.contains(id) == true {
            persistenceManager.removeFromFavorites(id: id)
                .map { _ in
                    presenter.setPhoto(isFavorite: false)
                    presenter.showAlert(isFavorite: false)
                }
            return
        }
        persistenceManager.saveToFavorites(id: id)
            .map { _ in
                presenter.setPhoto(isFavorite: true)
                presenter.showAlert(isFavorite: true)
            }
    }
}
