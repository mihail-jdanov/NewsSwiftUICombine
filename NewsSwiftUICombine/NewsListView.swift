//
//  NewsListView.swift
//  NewsSwiftUICombine
//
//  Created by Михаил Жданов on 26.02.2025.
//

import SwiftUI

struct NewsListView: View {
    
    @ObservedObject var viewModel = NewsListViewModel()
    
    var body: some View {
        Text("Hello, World!")
            .onAppear {
                viewModel.loadDataFuture()
            }
    }
    
}

#Preview {
    NewsListView()
}
