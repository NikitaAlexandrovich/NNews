//
//  APIResponse.swift
//  NNews
//
//  Created by Никита Ходарёнок on 19.01.22.
//

import Foundation

struct APIResponse: Decodable {
    
    let status: String
    let totalResults: Int?
    let articles: [NewsArticle]?
    
    let code: String?
    let message: String?
    
}
