//
//  MainWorker.swift
//  UnsplashFoto
//
//  Created by Владислав on 09.02.2024.
//

import Foundation

protocol MainWorkerProtocol {
    
}

final class MainWorker: MainWorkerProtocol {
    
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    
}
