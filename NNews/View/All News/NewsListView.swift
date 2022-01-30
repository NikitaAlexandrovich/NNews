//
//  NewsListView.swift
//  NNews
//
//  Created by Никита Ходарёнок on 17.01.22.
//

import SwiftUI

struct NewsListView: View {
    
    let newsArticles: [NewsArticle]
    
    @State private var selectedArticle: NewsArticle?
    
    var body: some View {
        
        List{
            ForEach(newsArticles) { newsArticles in
                NewsRowView(newsRow: newsArticles)
                    .onTapGesture {
                        selectedArticle = newsArticles
                    }
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        
        .listStyle(.plain)
        .sheet(item: $selectedArticle){
            WebCustomView(newsArticle: $0)
        }
    }
}

struct NewsListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            NewsListView(newsArticles: NewsArticle.previewData)
        }
    }
}
