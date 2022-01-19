//
//  NewsListView.swift
//  NNews
//
//  Created by Никита Ходарёнок on 17.01.22.
//

import SwiftUI

struct NewsListView: View {
    
    let newsArticles: [NewsArticle]
    
    var body: some View {
        
        List{
            ForEach(newsArticles) { newsArticles in
                NewsRowView(newsRow: newsArticles)
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        // in title in future use (headlines or theme news)
        .navigationBarTitle("News", displayMode: .automatic)
        .listStyle(.plain)
    }
}

struct NewsListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            NewsListView(newsArticles: NewsArticle.previewData)
        }
    }
}
