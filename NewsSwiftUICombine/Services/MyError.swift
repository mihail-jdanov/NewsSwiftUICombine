//
//  MyError.swift
//  NewsSwiftUICombine
//
//  Created by Михаил Жданов on 26.02.2025.
//

import Foundation

class MyError: Error {
    
    let message: String
    
    init(message: String) {
        self.message = message
    }
    
}
