//
//  UserAccountModel.swift
//  NNews
//
//  Created by Никита Ходарёнок on 24.01.22.
//

import Foundation

struct UserAccountModel {
    
    var userName: String
    var userEmail: String
    var userImage: URL
    
    init() {
        userName = "NaN"
        userEmail = "NaN"
        userImage = URL(fileURLWithPath: "")
    }
}

extension UserAccountModel: Codable{}
extension UserAccountModel: Equatable{}
