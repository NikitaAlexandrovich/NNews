//
//  SourcesResponse.swift
//  NNews
//
//  Created by Никита Ходарёнок on 20.01.22.
//

import Foundation

struct NewsSource{
    let id: String
    let name: String
}

struct Sources{
    let status: String
    let sources: [NewsSource]
}

extension NewsSource: Codable{}
extension NewsSource: Equatable{}
extension NewsSource: Identifiable{}

extension Sources: Codable{}
extension Sources: Equatable{}
