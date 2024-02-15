//
//  UIViewController + Extension.swift
//  UnsplashFoto
//
//  Created by Владислав on 15.02.2024.
//

import UIKit

extension UIViewController {
    func setupCustomBackButton() {
        if let backButtonImage = UIImage(systemName: "chevron.backward.square")?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal) {
            let resizedBackButtonImage = backButtonImage.resized(to: CGSize(width: 30, height: 30))
            let backButton = UIBarButtonItem(image: resizedBackButtonImage, style: .plain, target: self, action: #selector(customBackButtonTapped))
            navigationItem.leftBarButtonItem = backButton
        }
    }
    
    @objc func customBackButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
