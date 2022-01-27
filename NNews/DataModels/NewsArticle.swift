//
//  NewsArticle.swift
//  NNews
//
//  Created by Никита Ходарёнок on 16.01.22.
//

import Foundation

fileprivate let relativeDateFormatter = RelativeDateTimeFormatter()

struct NewsArticle{
    
//    let id = UUID()

    let source: Source
    let title: String
    let url: String
    let publishedAt: Date
    
    let description: String?
    let urlToImage: String?
        
    var descriptionText: String {
        var resultDescription = description ?? ""
        resultDescription = resultDescription.replacingOccurrences(of: "<table><tr><td></td></tr><tr><td>", with: "")
        resultDescription = resultDescription.replacingOccurrences(of: "</td></tr>", with: "")
        resultDescription = resultDescription.replacingOccurrences(of: "<ol><li>", with: "")
        resultDescription = resultDescription.replacingOccurrences(of: "</li><li>", with: "")
        
        return resultDescription
    }
    
    var captionText: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        
        return "\(relativeDateFormatter.localizedString(for: publishedAt, relativeTo: Date())) | \(dateFormatter.string(from: publishedAt))"
    }
    
    var articleURL: URL {
        URL(string: url)!
    }
    
    var imageURL: URL? {
        guard let urlToImage = urlToImage else {
            return nil
        }
        return URL(string: urlToImage)
    }
}

extension NewsArticle: Codable{}
extension NewsArticle: Equatable{}
extension NewsArticle: Identifiable{
    var id: String { url }
}

struct Source {
    let name: String
}

extension Source: Codable {}
extension Source: Equatable {}

extension NewsArticle {
    
    static var previewData: [NewsArticle] {
        let previewDataURL = Bundle.main.url(forResource: "previewData", withExtension: "json")!
        let data = try! Data(contentsOf: previewDataURL)
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        let apiResponse = try! jsonDecoder.decode(APIResponse.self, from: data)
        return apiResponse.articles ?? []
    }
    
}
