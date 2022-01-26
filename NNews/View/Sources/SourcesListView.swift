//
//  SourcesListView.swift
//  NNews
//
//  Created by Никита Ходарёнок on 26.01.22.
//

import SwiftUI

struct SourcesListView: View {
    
    let newsSources: [NewsSource]
    
    @State private var selectedArticle: NewsSource?
    
    var body: some View {
        
        List{
            ForEach(newsSources) { newsArticles in
                SourceRowView(source: newsArticles)
                    .onTapGesture {
                        selectedArticle = newsArticles
                    }
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .padding(.horizontal)
        .listStyle(.plain)
//        .sheet(item: $selectedArticle){
//            WebCustomView(newsArticle: $0)
//        }
    }
}

struct SourcesListView_Previews: PreviewProvider {
    static var previews: some View {
        SourcesListView(newsSources: [NewsSource(id: "hhh", name: "hhbvbv")])
    }
}
