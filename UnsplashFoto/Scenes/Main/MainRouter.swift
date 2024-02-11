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
    weak var viewController: MainViewController?
    
    //MARK: - init(_:)
    init(viewController: MainViewController) {
        self.viewController = viewController
    }
    
    func routeToDetail(with photoViewModel: PhotoViewModel) {
        let detailVC = DetailViewController()
        let presenter = DetailPresenter()
        detailVC.presenter = presenter
        presenter.viewController = detailVC
        presenter.presentPhotoDetails(with: photoViewModel)
        viewController?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
