//
//  SourceNewsView.swift
//  NNews
//
//  Created by Никита Ходарёнок on 17.01.22.
//

import SwiftUI

struct SourceNewsView: View {
    
    @StateObject var sourcesModel = SourcesViewModel()
        
    var body: some View {
        NavigationView {
            SourcesListView(newsSources: sources)
                .overlay(errorsView)
                .navigationTitle("News Sources")
        }
        .onAppear{
            update()
        }
    }
    
    private var sources: [NewsSource] {
        if case .success(let sources) = sourcesModel.statys {
            return sources
        } else {
            return []
        }
    }
    
    @ViewBuilder
    private var errorsView: some View {
        switch sourcesModel.statys {
        case .empty:
            ProgressView()
//            EmptyServerView(text: "No sources", image: Image(systemName: "folder.badge.questionmark"))
            
        case .success(let sources) where sources.isEmpty:
            EmptyServerView(text: "No Sources", image: Image(systemName: "nosign"))
            
        case .failure(let error):
            ServerErrorView(text: error.localizedDescription) {
                
            }
            
        default: EmptyView()
            
        }
    }
    
    private func update(){
        Task{
            await sourcesModel.sourcesArticle()
        }
    }
}

struct SourceNewsView_Previews: PreviewProvider {
    static var previews: some View {
        SourceNewsView()
    }
}
