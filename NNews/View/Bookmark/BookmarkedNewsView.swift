//
//  BookmarkedNewsView.swift
//  NNews
//
//  Created by Никита Ходарёнок on 17.01.22.
//

import SwiftUI

struct BookmarkedNewsView: View {
    
    @EnvironmentObject var savedNews: SaveNewsDataStoreModel
    
    var body: some View {
        if savedNews.savedNews.isEmpty {
            EmptySaveNewsView()
        }
        else {
            NewsListView(newsArticles: savedNews.savedNews)
                .navigationBarTitle("Saved news", displayMode: .automatic)
        }
    }
}

struct BookmarkedNewsView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkedNewsView()
    }
}
