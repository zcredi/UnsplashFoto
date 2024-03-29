//
//  SceneDelegate.swift
//  UnsplashFoto
//
//  Created by Владислав on 08.02.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    let sceneFactory = DefaultSceneFactory()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = MainTabBarController(sceneFactory: sceneFactory)
        window?.makeKeyAndVisible()
    }
}

