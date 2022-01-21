//
//  APIModel.swift
//  NNews
//
//  Created by Никита Ходарёнок on 20.01.22.
//

import Foundation

struct APIModel{
    var baseAPI: String
    var everything: String
    var topHeadlines: String
    var APIKey: String
    var source: String
    
    init() {
        baseAPI = "https://newsapi.org/v2/"
        everything = "everything"
        topHeadlines = "top-headlines"
        APIKey = "39b2bb9626224f81839de256103cf2ae"
        source = "sources"
    }
}

extension APIModel: Codable{}
extension APIModel: Equatable{}
