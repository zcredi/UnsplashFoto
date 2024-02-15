//
//  FavoriteInteractor.swift
//  UnsplashFoto
//
//  Created by Владислав on 14.02.2024.
//

import Foundation

protocol FavoriteBusinessLogic {
    func fetchFavorites()
    func didTapFavoriteButton(_ id: String, completion: (() -> Void)?)
}

final class FavoriteInteractor: FavoriteBusinessLogic {
    private let presenter: FavoritePresentationLogic?
    private let persistenceManager: PersistenceManager
    private let worker: FavoriteWorkerProtocol
    
    init(
        presenter: FavoritePresentationLogic,
        persistenceManager: PersistenceManager,
        worker: FavoriteWorkerProtocol
    ) {
        self.presenter = presenter
        self.persistenceManager = persistenceManager
        self.worker = worker
    }
    
    func fetchFavorites() {
        guard let favoritesIds = persistenceManager.favorites() else { return }
        
        var favoriteViewModels = [FavoriteViewModel]()
        let dispatchGroup = DispatchGroup()

        for id in favoritesIds {
            dispatchGroup.enter()
            worker.fetchPhotoDetails(by: id) { [weak self] result in
                defer { dispatchGroup.leave() }
                switch result {
                case .success(let photo):
                    let viewModel = FavoriteViewModel(
                        id: photo.id ?? "",
                        authorName: photo.user.name,
                        imageUrl: photo.urls?.thumb ?? "",
                        downloads: photo.downloads ?? 0,
                        profilImage: photo.user.profile_image.small,
                        createdAt: photo.createdAt ?? "",
                        location: photo.location?.city ?? ""
                    )
                    favoriteViewModels.append(viewModel)
                case .failure(let error):
                    print("Error fetching photo details: \(error)")
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.presenter?.presentFavorites(favoriteViewModels)
        }
    }
    
    func didTapFavoriteButton(_ id: String, completion: (() -> Void)?) {
           if persistenceManager.favorites()?.contains(id) == true {
               persistenceManager.removeFromFavorites(id: id)
                   .map { [weak self] _ in
                       self?.fetchFavorites()
                       completion?() 
                   }
           }
       }
}
