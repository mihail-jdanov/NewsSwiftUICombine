//
//  NewsItem.swift
//  NewsSwiftUICombine
//
//  Created by Михаил Жданов on 26.02.2025.
//

import Foundation

struct NewsItem: Codable, Identifiable {
    
    let id = UUID()
    let author: String?
    let title: String
    let publishedAt: String
    let urlToImage: String?
    let description: String?
    let content: String
    
}
