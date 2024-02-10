//
//  MainTabBarController.swift
//  UnsplashFoto
//
//  Created by Владислав on 08.02.2024.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    private let sceneFactory: SceneFactory
    
    init(sceneFactory: SceneFactory) {
        self.sceneFactory = sceneFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        setupItems()
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = .primaryDark
        tabBar.tintColor = .primaryBlueAccent
        tabBar.unselectedItemTintColor = .white
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.primarySoft.cgColor
    }
    
    private func setupItems() {
        let mainVC = sceneFactory.makeHomeScene()
        let favoriteVC = FavoriteViewController()
        
        setViewControllers([mainVC, favoriteVC], animated: true)
        
        guard let items = tabBar.items else { return }
        
        items[0].title = "Main"
        items[1].title = "Favorite"
        
        items[0].image = UIImage(named: "mainTabBar")
        items[1].image = UIImage(named: "favoriteTabBar")
        
        UITabBarItem.appearance().setTitleTextAttributes([.font : UIFont.robotoBold16() as Any], for: .normal)
    }
}
