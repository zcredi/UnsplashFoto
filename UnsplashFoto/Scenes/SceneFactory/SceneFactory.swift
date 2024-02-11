//
//  SceneFactory.swift
//  UnsplashFoto
//
//  Created by Владислав on 09.02.2024.
//

import UIKit

public protocol SceneFactory {
    func makeHomeScene() -> UIViewController
}

final class DefaultSceneFactory: SceneFactory {
    func makeHomeScene() -> UIViewController {
        let viewController = MainViewController()
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        let router = MainRouter(viewController: viewController)
        
        let networkManager = NetworkService()
        let worker = MainWorker(networkService: networkManager)

        viewController.interactor = interactor
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        viewController.router = router
        router.viewController = viewController
        
        return viewController
    }
}
