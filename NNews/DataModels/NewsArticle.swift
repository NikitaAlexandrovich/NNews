//
//  NewsArticle.swift
//  NNews
//
//  Created by Никита Ходарёнок on 16.01.22.
//

import Foundation

fileprivate let relativeDateFormatter = RelativeDateTimeFormatter()

struct Article{
    
    let id = UUID()

        let source: Source
        let title: String
        let url: String
        let publishedAt: Date
        
        let description: String?
        let urlToImage: String?
        
        
//        enum CodingKeys: String, CodingKey {
//            case source
//            case title
//            case url
//            case publishedAt
//            case author
//            case description
//            case urlToImage
//        }
        
        
        var descriptionText: String {
            description ?? ""
        }
        
        var captionText: String {
            "\(relativeDateFormatter.localizedString(for: publishedAt, relativeTo: Date()))"
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

struct Source {
    let name: String
}
