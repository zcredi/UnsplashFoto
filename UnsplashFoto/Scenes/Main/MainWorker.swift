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
        let url = "https://api.unsplash.com/photos/random?client_id=\(Configuration.unsplashAccessKey)&count=30"
        let request = AF.request(url)
        
        request.responseDecodable(of: [UnsplashPhoto].self) { response in
//            self.logResponse(response)
            
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

//MARK: - Logging Response
extension MainWorker {
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
