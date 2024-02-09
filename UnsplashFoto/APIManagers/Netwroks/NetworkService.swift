//
//  NetworkService.swift
//  UnsplashFoto
//
//  Created by Владислав on 09.02.2024.
//

import Foundation

struct HTTPMethod {
    static let get = HTTPMethod(rawValue: "GET")

    let rawValue: String
}

enum NetworkError: Error {
    case badData
    case badResponse
    case badRequest
    case badDecode
    case unknown(String)
}

protocol NetworkProtocol {
    func fetchData<T: Codable>(
        url: URL,
        httpMethod: HTTPMethod,
        body: Encodable?,
        headers: [String: String]?,
        completion: @escaping (Result<T, NetworkError>) -> Void
    )
}

final class NetworkService: NetworkProtocol {
    
    private let decoder = JSONDecoder()
        
    private var session: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = true
        configuration.waitsForConnectivity = true
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 250
        return URLSession(configuration: configuration)
    }
    
    init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    // Этот метод получает данные из сети и декодирует их в указанный тип модели
    func fetchData<T: Codable>(
        url: URL,
        httpMethod: HTTPMethod = .get,
        body: Encodable? = nil,
        headers: [String: String]? = nil,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        // Создаем задачу для получения данных
        session.dataTask(with: request) { data, response, error in
            // Проверяем, есть ли ошибка или данные
            guard let data = data, error == nil else {
                return completion(.failure(.badData))
            }
            
            guard let response = response as? HTTPURLResponse else {
                return completion(.failure(.badResponse))
            }
            
            let responseString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            
            switch response.statusCode {
            case 200...299:
                do {
                    let decodedData = try self.decoder.decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch let error {
                    print(error.localizedDescription)
                    completion(.failure(.badDecode))
                }
            case 400:
                completion(.failure(.badRequest))
            default:
                completion(.failure(.unknown("Дефолтная ошибка, что поделать...")))
            }
        }.resume()
    }
}
