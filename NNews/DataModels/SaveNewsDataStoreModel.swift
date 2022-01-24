//
//  SaveNewsDataStoreModel.swift
//  NNews
//
//  Created by Никита Ходарёнок on 24.01.22.
//

import SwiftUI

@MainActor
class SaveNewsDataStoreModel: ObservableObject {

    @Published var savedNews: [NewsArticle] = []
    private let savedNewsStore = UserDataStore<[NewsArticle]>(filename: UserDataStoreModel.shared.accountInformation.userEmail)
    
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
    
    func addNews(for news: NewsArticle) {
        guard !checkStatus(for: news) else {
            return
        }

        savedNews.insert(news, at: 0)
        savedNewsUpdate()
    }
    
    func deleteNews(for news: NewsArticle) {
        guard let index = savedNews.firstIndex(where: {
            $0.id == news.id
        }) else {
            return
        }
        savedNews.remove(at: index)
        savedNewsUpdate()
    }
    
    func checkStatus(for news: NewsArticle) -> Bool {
        savedNews.first {
            news.id == $0.id
        } != nil
    }
}
