//
//  FavoriteWorker.swift
//  UnsplashFoto
//
//  Created by Владислав on 14.02.2024.
//

import Foundation
import Alamofire

protocol FavoriteWorkerProtocol {
    func fetchPhotoDetails(by id: String, completion: @escaping (Result<UnsplashPhoto, Error>) -> Void)
}

final class FavoriteWorker: FavoriteWorkerProtocol {
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func fetchPhotoDetails(by id: String, completion: @escaping (Result<UnsplashPhoto, Error>) -> Void) {
            let url = "https://api.unsplash.com/photos/\(id)?client_id=\(Configuration.unsplashAccessKey)"
            AF.request(url).responseDecodable(of: UnsplashPhoto.self) { response in
//                self.logResponse(response)
                switch response.result {
                case .success(let photo):
                    completion(.success(photo))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
}

//MARK: - Logging Response
extension FavoriteWorker {
    private func logResponse<T>(_ response: AFDataResponse<T>) {
        if let request = response.request {
            print("Request: \(request)")
        }
        if let response = response.response {
            print("Response: \(response)")
        }
        if let data = response.data, let jsonString = String(data: data, encoding: .utf8) {
            print("Response Data: \(jsonString)")
        }
        if let error = response.error {
            print("Error: \(error)")
        }
    }
}
