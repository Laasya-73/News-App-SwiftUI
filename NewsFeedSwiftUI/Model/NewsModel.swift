//
//  NewsModel.swift
//  NewsFeedSwiftUI
//
//  Created by Laasya Priya vemuri on 9/28/26.
//

import Foundation

// MARK: - News Model

struct NewsResponse: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article Model

struct Article: Decodable, Identifiable {
    let id = UUID()
    let title: String
    let description: String?
    let urlToImage: String?
    let publishedAt: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case urlToImage
        case publishedAt
    }
}
