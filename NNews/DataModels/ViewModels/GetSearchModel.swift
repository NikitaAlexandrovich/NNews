//
//  GetSearchModel.swift
//  NNews
//
//  Created by Никита Ходарёнок on 26.01.22.
//

import Foundation
import SwiftUI

@MainActor
class GetSearchModel: ObservableObject {

    @Published var statys: GetDataPhase<[NewsArticle]> = .empty
    @Published var searchQuery = ""
    
    private let newsAPI = APIManager.declare
    
    func searchArticle() async {
        if Task.isCancelled { return }
        
        let searchQuery = self.searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        statys = .empty
        
        if searchQuery.isEmpty {
            return
        }
        
        do {
            let articles = try await newsAPI.searchNews(for: searchQuery)
            if Task.isCancelled { return }
            statys = .success(articles)
        } catch {
            if Task.isCancelled { return }
            statys = .failure(error)
        }
    }
}
