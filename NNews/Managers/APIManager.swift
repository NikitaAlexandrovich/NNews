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
    
    func getNews(from category: Category, country: Country) async throws -> [NewsArticle] {
        let newsUrl = await createNewsURL(from: category, country: country)
        let (data, response) = try await session.data(from: newsUrl)
        
        guard let response = response as? HTTPURLResponse else{
            throw NSError(domain: "API News", code: -1, userInfo: [NSLocalizedDescriptionKey: "Response was bad."])
        }
        
        switch response.statusCode {
        case (200...299), (400...499):
            let response = try jsonDecoder.decode(APIResponse.self, from: data)
            if response.status == "ok"{
                return response.articles ?? []
            } else {
                throw NSError(domain: "API News", code: -1, userInfo: [NSLocalizedDescriptionKey: response.message ?? "Error was happened"])
            }
            
        default:
            throw NSError(domain: "API News", code: -1, userInfo: [NSLocalizedDescriptionKey: "Server error."])
        }
    }
    
    @MainActor private func createNewsURL(from category: Category, country: Country) -> URL{
        let apiStruct = APIDataStoreModel.shared.APIBased
        var newsUrl = apiStruct.baseAPI
        newsUrl += apiStruct.topHeadlines
        newsUrl += "?category=\(category.rawValue)&country=\(country.getCoutry)&apiKey="
        newsUrl += apiStruct.APIKey
        return URL(string: newsUrl)!
    }
}
