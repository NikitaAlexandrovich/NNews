//
//  APIManager.swift
//  NNews
//
//  Created by Никита Ходарёнок on 21.01.22.
//

import Foundation

struct APIManager{
    
    static let declare = APIManager()
    
    private let session = URLSession.shared
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
//    func getNews(from category: Category, country: Country) async throws -> [NewsArticle] {
//            try await fetchArticles(from: createNewsURL(from: category, country))
//    }
    
//    private func createNewsURL(from category: Category, country: Country) -> URL{
//    }
}
