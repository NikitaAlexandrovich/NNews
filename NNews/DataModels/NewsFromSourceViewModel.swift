//
//  NewsFromSourceViewModel.swift
//  NNews
//
//  Created by Никита Ходарёнок on 27.01.22.
//

import Foundation
import SwiftUI

@MainActor
class NewsFromSourceViewModel: ObservableObject {

    @Published var statys: GetDataPhase<[NewsArticle]> = .empty
//    @Published var sourceID = ""
    
    private let newsAPI = APIManager.declare
    
    func sourceArticle(sourceID: String) async {
        if Task.isCancelled { return }
        statys = .empty
        do {
            let articles = try await newsAPI.getNewsFromSelectedSource(from: sourceID)
            if Task.isCancelled { return }
            statys = .success(articles)
        } catch {
            if Task.isCancelled { return }
            statys = .failure(error)
        }
    }
}
