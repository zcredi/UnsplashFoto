//
//  SceneFactory.swift
//  UnsplashFoto
//
//  Created by Владислав on 09.02.2024.
//

import UIKit

protocol SceneFactory {
    func makeHomeScene() -> UIViewController
    func makeDetailScene(model: PhotoViewModel, router: Any) -> UIViewController
    func makeFavoriteScene() -> UIViewController
}

final class DefaultSceneFactory: SceneFactory {
    private let persistence = PersistenceManagerImpl()
    
    func makeHomeScene() -> UIViewController {
        let router = MainRouter(factory: self)
        let viewController = MainViewController(router: router)
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        let networkManager = NetworkService()
        let worker = MainWorker(networkService: networkManager)
        
        router.viewController = viewController
        viewController.interactor = interactor
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        router.viewController = viewController
        
        return viewController
    }
    
    func makeDetailScene(model: PhotoViewModel, router: Any) -> UIViewController {
        let presenter = DetailPresenter()
        let interactor = DetailInteractor(presenter: presenter, persistenceManager: persistence, model: model)
        let detailVC = DetailViewController(interactor: interactor)
        presenter.view = detailVC
        return detailVC
    }
    
    func makeFavoriteScene() -> UIViewController {
        let networkService = NetworkService()
        let worker = FavoriteWorker(networkService: networkService)
        let presenter = FavoritePresenter()
        let persistenceManager = PersistenceManagerImpl()
        let interactor = FavoriteInteractor(presenter: presenter, persistenceManager: persistenceManager, worker: worker)
        let router = FavoriteRouter(factory: self)
        let viewController = FavoriteViewController()
        viewController.interactor = interactor
        viewController.router = router
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }
}


