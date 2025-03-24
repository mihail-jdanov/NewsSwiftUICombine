//
//  NewsService.swift
//  NewsSwiftUICombine
//
//  Created by Михаил Жданов on 26.02.2025.
//

import Foundation
import Combine

class NewsService {
    
    private var networkClient = NetworkClient()
    
    func loadNews(completion: @escaping (Result<NewsList, Error>) -> Void) {
        networkClient.request(path: "everything?q=tesla", method: .get) { result in
            completion(result)
        }
    }
    
    func loadNewsFuture() -> AnyPublisher<NewsList, Error> {
        return networkClient.requestFuture(path: "everything?q=tesla", method: .get)
    }
    
}
