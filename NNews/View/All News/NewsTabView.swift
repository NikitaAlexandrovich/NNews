//
//  NewsTabView.swift
//  NNews
//
//  Created by Никита Ходарёнок on 18.01.22.
//

import SwiftUI

struct NewsTabView: View {
    
    @StateObject var getNewsModel = GetNewsModel()
    
    var body: some View {
        NavigationView{
            NewsListView(newsArticles: newsArticle)
                .overlay(overlayView)
                .refreshable {
                    updateNews()
                }
                .onAppear{
                    updateNews()
                }
                .navigationTitle(getNewsModel.selectedCategory.topHeadlinesGet)
        }
    }
    
    private var newsArticle: [NewsArticle] {
        if case let .success(articles) = getNewsModel.phase {
            return articles
        } else {
            return []
        }
    }
    
    @ViewBuilder
    private var overlayView: some View {
        
        switch getNewsModel.phase {
        case .empty:
            ProgressView()
        case .success(let articles) where articles.isEmpty:
            EmptyServerView(text: "Response contains no news", image: Image(systemName: "pip.remove"))
        case .failure(let error):
            ServerErrorView(text: error.localizedDescription){
                updateNews()
            }
        default: EmptyView()
        }
    }
    
    private func updateNews(){
        async {
            await getNewsModel.loadNews()
        }
    }
    
}

struct NewsTabView_Previews: PreviewProvider {
    static var previews: some View {
        NewsTabView(getNewsModel: GetNewsModel(articles: NewsArticle.previewData))
    }
}
