//
//  UserDataStoreModel.swift
//  NNews
//
//  Created by Никита Ходарёнок on 24.01.22.
//

import SwiftUI

@MainActor
class UserDataStoreModel: ObservableObject {

    @Published var accountInformation: UserAccountModel = UserAccountModel()
    private let accountInformationStore = UserDataStore<UserAccountModel>(filename: "User")
    
    static let shared = UserDataStoreModel()
    private init() {
        Task {
            await load()
        }
    }
    
    private func load() async {
        accountInformation = await accountInformationStore.load() ?? UserAccountModel()
    }
    
    func UserDataUpdated() {
        let account = self.accountInformation
        Task {
            await accountInformationStore.save(account)
        }
    }
}
