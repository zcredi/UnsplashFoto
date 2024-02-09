//
//  MainViewController.swift
//  UnsplashFoto
//
//  Created by Владислав on 09.02.2024.
//

import UIKit

protocol MainDisplayLogic: AnyObject {

}

final class MainViewController: UIViewController, MainDisplayLogic {
    var interactor: HomeBusinessLogic?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}
