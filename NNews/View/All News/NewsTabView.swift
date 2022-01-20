//
//  NewsTabView.swift
//  NNews
//
//  Created by Никита Ходарёнок on 18.01.22.
//

import SwiftUI

struct NewsTabView: View {
    var body: some View {
        NavigationView{
            NewsListView(newsArticles: NewsArticle.previewData)
        }
    }
}

struct NewsTabView_Previews: PreviewProvider {
    static var previews: some View {
        NewsTabView()
    }
}
