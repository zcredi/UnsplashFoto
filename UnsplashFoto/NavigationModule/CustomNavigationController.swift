//
//  CustomNavigationController.swift
//  UnsplashFoto
//
//  Created by Владислав on 15.02.2024.
//

import UIKit

class CustomNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarAppearance()
        
        navigationBar.tintColor = .white
        
        if let backButtonImage = UIImage(systemName: "chevron.backward.square")?.withTintColor(.white, renderingMode: .alwaysOriginal) {
            let resizedBackButtonImage = backButtonImage.resized(to: CGSize(width: 30, height: 30))
            navigationBar.backIndicatorImage = resizedBackButtonImage
            navigationBar.backIndicatorTransitionMaskImage = resizedBackButtonImage
        }
        
        navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
    }
    
    private func setupNavigationBarAppearance() {
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.primarySoft
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
        }
    }
}

