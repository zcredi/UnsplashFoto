//
//  MainInteractor.swift
//  UnsplashFoto
//
//  Created by Владислав on 09.02.2024.
//

import Foundation

protocol MainBusinessLogic {
   
}

final class MainInteractor: MainBusinessLogic {
    var presenter: MainPresentationLogic?
    var worker: MainWorkerProtocol?
    
}
