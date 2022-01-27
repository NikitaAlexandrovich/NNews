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
        try await getAllNews(newsUrl: createNewsURL(from: category, country: country))
    }
    
    private func getAllNews(newsUrl: URL) async throws -> [NewsArticle] {
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
    
    func searchNews(for qKey: String) async throws -> [NewsArticle] {
        try await getAllNews(newsUrl: createSearchNewsURL(from: qKey))
    }
    
    @MainActor private func createSearchNewsURL(from qKey: String) -> URL{
        let query = qKey.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? qKey
        let apiStruct = APIDataStoreModel.shared.APIBased
        var newsUrl = apiStruct.baseAPI
        newsUrl += apiStruct.everything
        newsUrl += "?q=\(query)&apiKey="
        newsUrl += apiStruct.APIKey
        print(newsUrl)
        return URL(string: newsUrl)!
    }
    
    private func getSources(sourcesUrl: URL) async throws -> [NewsSource] {
        let (data, response) = try await session.data(from: sourcesUrl)
        
        guard let response = response as? HTTPURLResponse else{
            throw NSError(domain: "API News", code: -1, userInfo: [NSLocalizedDescriptionKey: "Response was bad."])
        }
        
        switch response.statusCode {
        case (200...299), (400...499):
            let response = try jsonDecoder.decode(Sources.self, from: data)
            if response.status == "ok"{
                return response.sources
            } else {
                throw NSError(domain: "API News", code: -1)
            }
        default:
            throw NSError(domain: "API News", code: -1)
        }
    }
    
    @MainActor private func createGetSourcesURL() -> URL {
        let apiStruct = APIDataStoreModel.shared.APIBased
        var newsUrl = apiStruct.baseAPI
        newsUrl += apiStruct.topHeadlines
        newsUrl += "/\(apiStruct.source)?apiKey="
        newsUrl += apiStruct.APIKey
        return URL(string: newsUrl)!
    }
    
    func getListSources() async throws -> [NewsSource] {
        try await getSources(sourcesUrl: createGetSourcesURL())
    }
    
    @MainActor private func createSelectedSourceURL(from sourceName: String) -> URL {
        let apiStruct = APIDataStoreModel.shared.APIBased
        var newsUrl = apiStruct.baseAPI
        newsUrl += apiStruct.topHeadlines
        newsUrl += "?\(apiStruct.source)=\(sourceName)&apiKey="
        newsUrl += apiStruct.APIKey
        print(newsUrl)
        return URL(string: newsUrl)!
    }
    
    func getNewsFromSelectedSource(from sourceID: String) async throws -> [NewsArticle] {
        try await getAllNews(newsUrl: createSelectedSourceURL(from: sourceID))
    }
}
