//
//  MainTabBarController.swift
//  UnsplashFoto
//
//  Created by Владислав on 08.02.2024.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    private let sceneFactory: SceneFactory
    
    //MARK: - init(_:)
    init(sceneFactory: SceneFactory) {
        self.sceneFactory = sceneFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        setupItems()
    }
    
    private func setupTabBar() {
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.primaryDark
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
        
        tabBar.backgroundColor = .primaryDark
        tabBar.tintColor = .primaryBlueAccent
        tabBar.unselectedItemTintColor = .white
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.primarySoft.cgColor
    }
    
    private func setupItems() {
        let mainVC = sceneFactory.makeHomeScene()
        let mainNavController = UINavigationController(rootViewController: mainVC)
        mainNavController.tabBarItem = UITabBarItem(title: "Main", image: UIImage(named: "mainTabBar"), tag: 0)
        
        let favoriteVC = sceneFactory.makeFavoriteScene()
        let favoriteNavController = UINavigationController(rootViewController: favoriteVC)
        favoriteNavController.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(named: "favoriteTabBar"), tag: 1)
        
        setViewControllers([mainNavController, favoriteNavController], animated: true)
        
        UITabBarItem.appearance().setTitleTextAttributes([.font : UIFont.robotoBold16() as Any], for: .normal)
    }
}
