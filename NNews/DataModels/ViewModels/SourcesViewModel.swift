//
//  SourcesViewModel.swift
//  NNews
//
//  Created by Никита Ходарёнок on 26.01.22.
//

import SwiftUI

@MainActor
class SourcesViewModel: ObservableObject {

    @Published var statys: GetDataPhase<[NewsSource]> = .empty
    
    private let newsAPI = APIManager.declare
    
    func sourcesArticle() async {
        if Task.isCancelled { return }
        
        statys = .empty
        
        do {
            let sources = try await newsAPI.getListSources()
            if Task.isCancelled { return }
            statys = .success(sources)
        } catch {
            if Task.isCancelled { return }
            statys = .failure(error)
        }
    }
}
