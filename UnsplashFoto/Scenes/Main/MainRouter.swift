//
//  MainRouter.swift
//  UnsplashFoto
//
//  Created by Владислав on 11.02.2024.
//

import UIKit

protocol MainRoutingLogic {
    func routeToDetail(with photoViewModel: PhotoViewModel)
}

final class MainRouter: NSObject, MainRoutingLogic {
    private let factory: SceneFactory
    weak var viewController: MainViewController?
    
    //MARK: - init(_:)
    init(factory: SceneFactory) {
        self.factory = factory
    }
    
    func routeToDetail(with photoViewModel: PhotoViewModel) {
        let detailVC = factory.makeDetailScene(model: photoViewModel, router: self)
        viewController?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
