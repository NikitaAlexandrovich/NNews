//
//  UserSaveNewsModel.swift
//  NNews
//
//  Created by Никита Ходарёнок on 25.01.22.
//

import Foundation

struct UserSaveNewsModel {
    
    var userEmail: String
    var userSavedNews: NewsArticle
    
}

extension UserSaveNewsModel: Codable{}
extension UserSaveNewsModel: Equatable{}
//extension UserSaveNewsModel: Identifiable{}
