//
//  SearchNewsView.swift
//  NNews
//
//  Created by Никита Ходарёнок on 17.01.22.
//

import SwiftUI

struct SearchNewsView: View {
    
//    @State var searchKey: String = ""
//
//    var body: some View {
//        VStack{
//            TextField("Some title", text: $searchKey)
//                .textFieldStyle(.roundedBorder)
//            NewsListView(newsArticles: NewsArticle.previewData)
//        }
//        .navigationTitle("Search")
//    }

    
    @StateObject var searchModel = GetSearchModel()
        
    var body: some View {
        NavigationView {
            NewsListView(newsArticles: articles)
                .overlay(errorsView)
                .navigationTitle("Search everything news")
        }
        .searchable(text: $searchModel.searchQuery)
        .onSubmit(of: .search, search)
        .onChange(of: searchModel.searchQuery) { newValue in
            if newValue.isEmpty {
                searchModel.statys = .empty
            }
        }
    }
    
    private var articles: [NewsArticle] {
        if case .success(let articles) = searchModel.statys {
            return articles
        } else {
            return []
        }
    }
    
    @ViewBuilder
    private var errorsView: some View {
        switch searchModel.statys {
        case .empty:
            if !searchModel.searchQuery.isEmpty {
                ProgressView()
            }
            else {
                EmptyServerView(text: "Write keyword for search ", image: Image(systemName: "keyboard"))
            }
            
        case .success(let articles) where articles.isEmpty:
            EmptyServerView(text: "No News", image: Image(systemName: "nosign"))
            
        case .failure(let error):
            ServerErrorView(text: error.localizedDescription, retryAction: search)
            
        default: EmptyView()
            
        }
    }
    
    private func search() {
        let searchQuery = searchModel.searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        if !searchQuery.isEmpty {
        }
        
        Task {
            await searchModel.searchArticle()
        }
    }
}

struct SearchNewsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchNewsView()
            .previewDevice("iPhone 11")
    }
}
