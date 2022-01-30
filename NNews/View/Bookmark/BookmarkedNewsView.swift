//
//  BookmarkedNewsView.swift
//  NNews
//
//  Created by Никита Ходарёнок on 17.01.22.
//

import SwiftUI

struct BookmarkedNewsView: View {
    
    @EnvironmentObject var savedNews: SaveNewsDataStoreModel
    
    @State var saved: [NewsArticle] = []
    
    var body: some View {
        
        if savedNews.getSavedNewsForUser().isEmpty{
            EmptySaveNewsView()
        }
        else {
            NewsListView(newsArticles: savedNews.getSavedNewsForUser())
                .navigationBarTitle("Saved news", displayMode: .automatic)
        }
        
    }
}

struct BookmarkedNewsView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkedNewsView()
    }
}
