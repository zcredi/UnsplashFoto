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
            if let error = error {
                print("Ошибка запроса: \(error.localizedDescription)")
                return completion(.failure(.unknown("Ошибка запроса: \(error.localizedDescription)")))
            }

            guard let data = data, !data.isEmpty else {
                print("Данные отсутствуют или пустые")
                return completion(.failure(.badData))
            }

            guard let response = response as? HTTPURLResponse else {
                print("Ответ не является HTTPURLResponse")
                return completion(.failure(.badResponse))
            }

            switch response.statusCode {
            case 200...299:
                do {
                    let decodedData = try self.decoder.decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    print("Ошибка декодирования: \(error.localizedDescription)")
                    completion(.failure(.badDecode))
                }
            case 400...499:
                print("Ошибка запроса, статус код: \(response.statusCode)")
                completion(.failure(.badRequest))
            default:
                print("Неизвестная ошибка, статус код: \(response.statusCode)")
                completion(.failure(.unknown("Неизвестная ошибка, статус код: \(response.statusCode)")))
            }
        }.resume()
    }
}
