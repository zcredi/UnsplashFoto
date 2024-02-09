//
//  MainWorker.swift
//  UnsplashFoto
//
//  Created by Владислав on 09.02.2024.
//

import Foundation

protocol MainWorkerProtocol {
    func fetchRandomPhotos(completion: @escaping (Result<[UnsplashPhotoModel], NetworkError>) -> Void)
}

final class MainWorker: MainWorkerProtocol {
    
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchRandomPhotos(completion: @escaping (Result<[UnsplashPhotoModel], NetworkError>) -> Void) {
            guard let url = URL(string: "https://api.unsplash.com/photos/random?client_id=8z-SXwpvXB9oEoCHCPAeCxXL4iSsKn_GFtp6C7yedyc") else {
                completion(.failure(.badRequest))
                return
            }

            networkService.fetchData(url: url) { (result: Result<[UnsplashPhotoModel], NetworkError>) in
                completion(result)
            }
        }
    
}
