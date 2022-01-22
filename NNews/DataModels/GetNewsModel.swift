//
//  GetNewsModel.swift
//  NNews
//
//  Created by Никита Ходарёнок on 22.01.22.
//

import SwiftUI

@MainActor
class GetNewsModel: ObservableObject {
    
    @Published var phase = GetDataPhase<[NewsArticle]>.empty
    @Published var selectedCategory: Category
    @Published var selectedCountry: Country
    private let newsAPI = APIManager.declare
    
    init(articles: [NewsArticle]? = nil, selectedCategory: Category = .general, selectedCountry: Country = .My_Location) {
        if let articles = articles {
            self.phase = .success(articles)
        } else {
            self.phase = .empty
        }
        self.selectedCategory = selectedCategory
        self.selectedCountry = selectedCountry
    }
    
    func loadNews() async {
        phase = .empty
        do {
            let articles = try await newsAPI.getNews(from: selectedCategory, country: selectedCountry)
            phase = .success(articles)
        } catch {
//            print(error.localizedDescription)
            phase = .failure(error)
        }
    }
}

enum GetDataPhase<T> {
    
    case empty
    case success(T)
    case failure(Error)
}
