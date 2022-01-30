//
//  SaveNewsDataStoreModel.swift
//  NNews
//
//  Created by Никита Ходарёнок on 24.01.22.
//

import SwiftUI

@MainActor
class SaveNewsDataStoreModel: ObservableObject {
    
//    var userNewsId = UserDataStoreModel.shared.accountInformation.userEmail

    @Published var savedNews: [UserSaveNewsModel] = []
    private let savedNewsStore = UserDataStore<[UserSaveNewsModel]>(filename: "SavedNews")
    
    static let shared = SaveNewsDataStoreModel()
    private init() {
        Task {
            await load()
        }
    }
    
    private func load() async {
        savedNews = await savedNewsStore.load() ?? []
    }
    
    func savedNewsUpdate() {
        let saveNews = self.savedNews
        Task {
            await savedNewsStore.save(saveNews)
        }
    }
    
    func addNews(for news: UserSaveNewsModel) {
        guard !checkStatus(for: news) else {
            return
        }

        savedNews.insert(news, at: 0)
        savedNewsUpdate()
    }
    
    func deleteNews(for news: UserSaveNewsModel) {
        guard let index = savedNews.firstIndex(where: {
            $0.userSavedNews.id == news.userSavedNews.id
        }) else {
            return
        }
        savedNews.remove(at: index)
        savedNewsUpdate()
    }
    
    func checkStatus(for news: UserSaveNewsModel) -> Bool {
        savedNews.first {
            news.userEmail == $0.userEmail && news.userSavedNews.id == $0.userSavedNews.id
        } != nil
    }
    
    func getSavedNewsForUser() -> [NewsArticle] {
        
        var saved: [NewsArticle] = []
        for news in savedNews {
            if news.userEmail == UserDataStoreModel.shared.accountInformation.userEmail {
                saved.insert(news.userSavedNews, at: 0)
            }
        }
        var bufer = [NewsArticle]()
        for value in saved.reversed() {
           bufer += [value]
        }
        return bufer
    }
}
