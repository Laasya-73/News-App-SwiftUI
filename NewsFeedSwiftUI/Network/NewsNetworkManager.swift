//
//  NewsNetworkManager.swift
//  NewsFeedSwiftUI
//
//  Created by Laasya Priya vemuri on 9/28/26.
//

import SwiftUI

protocol NetworkManagerProtocol {
    func fetchNewsData(serverUrl: String) async -> [Article]?
}

class NewsNetworkManager: NetworkManagerProtocol {
    
    // MARK: - Property
    
    static let shared = NewsNetworkManager()
    
    // MARK: - Initializer
    
    private init() { }
    
    // MARK: - User Defined Methods
    
    func fetchNewsData(serverUrl: String) async -> [Article]? {
        guard let serverURL = URL(string: serverUrl) else {
            return nil
        }
        
        let request = URLRequest(url: serverURL)
        
        do {
            let (jsonData, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                return nil
            }
            
            let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: jsonData)
            return newsResponse.articles
        } catch {
            print("Log:: Failed to fetch or decode news data")
            return nil
        }
    }
}
