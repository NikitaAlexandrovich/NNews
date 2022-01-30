//
//  APIDataStorModel.swift
//  NNews
//
//  Created by Никита Ходарёнок on 21.01.22.
//

import SwiftUI

@MainActor
class APIDataStoreModel: ObservableObject {

    @Published var APIBased: APIModel = APIModel()
    private let APIBasedStore = UserDataStore<APIModel>(filename: "API")
    
    static let shared = APIDataStoreModel()
    private init() {
        Task {
            await load()
        }
    }
    
    private func load() async {
        APIBased = await APIBasedStore.load() ?? APIModel()
    }
    
    func APIDataUpdated() {
        let APIBased = self.APIBased
        Task {
            await APIBasedStore.save(APIBased)
        }
    }
}
