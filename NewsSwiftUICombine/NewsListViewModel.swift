//
//  NewsListViewModel.swift
//  NewsSwiftUICombine
//
//  Created by Михаил Жданов on 26.02.2025.
//

import Foundation
import Combine

class NewsListViewModel: ObservableObject {
    
    @Published var items: [NewsItem] = []
    
    private var newsService = NewsService()
    private var subscriptions: Set<AnyCancellable> = []
    
    func loadData() {
        newsService.loadNews { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.items = data.articles
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadDataFuture() {
        newsService.loadNewsFuture().sink { completion in
            switch completion {
            case .failure(let error):
                print(error.localizedDescription)
            case .finished:
                print("finished")
            }
        } receiveValue: { data in
            self.items = data.articles
        }.store(in: &subscriptions)
    }
    
}
