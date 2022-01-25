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
    
//    init() {
//        ForEach(savedNews.savedNews{ news in
//            if news.userEmail == UserDataStoreModel.shared.accountInformation.userEmail {
//                saved.insert(news.userSavedNews, at: 0)
//            }
//        }
////            for news in savedNews.savedNews {
////                if news.userEmail == UserDataStoreModel.shared.accountInformation.userEmail {
////                    saved.insert(news.userSavedNews, at: 0)
////                }
////            }
//    }
    
    var body: some View {
        
        if savedNews.getSavedNewsForUser().isEmpty{
            EmptySaveNewsView()
        }
        else {
            NewsListView(newsArticles: savedNews.getSavedNewsForUser())
                .navigationBarTitle("Saved news", displayMode: .automatic)
        }
        
    }
    
//    private func loadingSaveNews() {
//        for news in savedNews.savedNews {
//            if news.userEmail == UserDataStoreModel.shared.accountInformation.userEmail {
//                saved.insert(news.userSavedNews, at: 0)
//            }
//        }
//    }
}

struct BookmarkedNewsView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkedNewsView()
    }
}
