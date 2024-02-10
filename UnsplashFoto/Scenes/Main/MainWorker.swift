//
//  MainWorker.swift
//  UnsplashFoto
//
//  Created by Владислав on 09.02.2024.
//

import Foundation
import Alamofire

protocol MainWorkerProtocol {
    func fetchRandomPhotos(completion: @escaping (Result<[UnsplashPhoto], NetworkError>) -> Void)
}

final class MainWorker: MainWorkerProtocol {
    
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchRandomPhotos(completion: @escaping (Result<[UnsplashPhoto], NetworkError>) -> Void) {
            let url = "https://api.unsplash.com/photos/random?client_id=\(Configuration.unsplashAccessKey)&count=20"
            let request = AF.request(url)

            request.responseDecodable(of: [UnsplashPhoto].self) { response in
                switch response.result {
                case .success(let photos):
                    completion(.success(photos))
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(.failure(.unknown(error.localizedDescription)))
                }
            }
        }
}
