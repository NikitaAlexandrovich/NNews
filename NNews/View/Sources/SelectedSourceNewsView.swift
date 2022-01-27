//
//  SelectedSourceNewsView.swift
//  NNews
//
//  Created by Никита Ходарёнок on 26.01.22.
//

import SwiftUI

struct SelectedSourceNewsView: View {
    
    let source: NewsSource
    
    @StateObject var sourceNewsModel = NewsFromSourceViewModel()
    
    var body: some View {
        
        NewsListView(newsArticles: sourcesNews)
            .navigationTitle(source.name)
            .overlay(errorsView)
            .onAppear(perform: update)
    }

    private var sourcesNews: [NewsArticle] {
        if case .success(let sources) = sourceNewsModel.statys {
            return sources
        } else {
            return []
        }
    }
    
    @ViewBuilder
    private var errorsView: some View {
        switch sourceNewsModel.statys {
        case .empty:
            ProgressView()
//            EmptyServerView(text: "No sources", image: Image(systemName: "folder.badge.questionmark"))
            
        case .success(let sources) where sources.isEmpty:
            EmptyServerView(text: "No Source News", image: Image(systemName: "nosign"))
            
        case .failure(let error):
            ServerErrorView(text: error.localizedDescription, retryAction: update)
            
        default: EmptyView()
            
        }
    }
    
    private func update() {
        Task {
            await sourceNewsModel.sourceArticle(sourceID: source.id)
        }
    }
}

struct SelectedSourceNewsView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedSourceNewsView(source: NewsSource(id: "dvdv", name: "edvsc"))
    }
}
