//
//  NetworkClient.swift
//  NewsSwiftUICombine
//
//  Created by Михаил Жданов on 26.02.2025.
//

import Foundation
import Combine

enum Method: String {
    case get = "GET"
    case post = "POST"
}

class NetworkClient {
    
    private let config = NetworkConfiguration()
    
    func request<T: Codable>(path: String, method: Method, completion: @escaping (Result<T, Error>) -> Void) {
        let apiPath = "\(config.getBaseUrl())\(path)"
        guard let url = URL(string: apiPath) else {
            DispatchQueue.main.async {
                completion(.failure(MyError(message: "Wrong URL")))
            }
            return
        }
        var request = URLRequest(url: url)
        let headers = config.getHeaders()
        for header in headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let data = data, let content = JsonHelper.shared.decode(data: data, type: T.self) {
                DispatchQueue.main.async {
                    completion(.success(content))
                }
            } else {
                completion(.failure(MyError(message: "No data")))
            }
        }
        task.resume()
    }
    
    func requestFuture<T: Codable>(path: String, method: Method) -> AnyPublisher<T, Error> {
        let apiPath = "\(config.getBaseUrl())\(path)"
        guard let url = URL(string: apiPath) else {
            return Result<T, Error>.Publisher(MyError(message: "Wrong URL")).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        let headers = config.getHeaders()
        for header in headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        return Deferred {
            Future { promise in
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        promise(.failure(error))
                        return
                    }
                    if let data = data, let content = JsonHelper.shared.decode(data: data, type: T.self) {
                        promise(.success(content))
                    } else {
                        promise(.failure(MyError(message: "No data")))
                    }
                }
                task.resume()
            }
        }.eraseToAnyPublisher()
    }
    
}
