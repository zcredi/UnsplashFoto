//
//  MainTabBarController.swift
//  UnsplashFoto
//
//  Created by Владислав on 08.02.2024.
//

import UIKit

final class MainTabBarController: UITabBarController {

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
        let mainVC = MainViewController()
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
