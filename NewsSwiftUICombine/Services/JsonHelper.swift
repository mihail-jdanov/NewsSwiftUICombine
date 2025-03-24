//
//  JsonHelper.swift
//  NewsSwiftUICombine
//
//  Created by Михаил Жданов on 26.02.2025.
//

import Foundation

class JsonHelper {
    
    static let shared = JsonHelper()
    
    private var decoder = JSONDecoder()
    
    private init() {}
    
    func decode<T: Codable>(data: Data, type: T.Type) -> T? {
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
}
