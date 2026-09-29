//
//  NewsViewModel.swift
//  NewsFeedSwiftUI
//
//  Created by Laasya Priya vemuri on 9/28/26.
//

import SwiftUI
import Combine

//MARK: - News ViewModel Protocol

protocol NewsViewModelProtocol: AnyObject, Observable  {
    func fetchNewsFromNetwork() async
    func getArticlesCount() -> Int
    func getArticle(at index: Int) -> Article?
    func searchArticles(with searchText: String)
    func clearSearch()
    var articles: [Article] {get}
    var newsData: [Article]? {get}
}

//MARK: - News ViewModel

@Observable
class NewsViewModel: NewsViewModelProtocol {
    
    //MARK: - Properties
    
    var newsData: [Article]?
    private var objNetwork: NetworkManagerProtocol
    var isLoading: Bool = false
    var filteredArticles: [Article] = []
    private var isSearching: Bool = false
    
    var articles: [Article] {
         if isSearching {
             return filteredArticles
         }
         return newsData ?? []
     }
    
    //MARK: - Initializer
    
    init(objNetwork: NetworkManagerProtocol) {
        self.objNetwork = objNetwork
    }
    
    func fetchNewsFromNetwork() async {
        let fetchedArticles = await objNetwork.fetchNewsData(serverUrl: NewsConstants.newsURL.rawValue)
        self.newsData = fetchedArticles
    }
    
    func getArticlesCount() -> Int {
        articles.count
    }
    
    func getArticle(at index: Int) -> Article?  {
        guard index >= 0, index < articles.count else {
            return nil
        }
        return articles[index]
    }
    
    func searchArticles(with searchText: String) {
        let trimmedText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedText.isEmpty else {
            clearSearch()
            return
        }
        
        isSearching = true
        let articles = newsData ?? []
        filteredArticles = articles.filter { article in
            article.title.localizedCaseInsensitiveContains(trimmedText)
        }
    }
    
    func clearSearch() {
        isSearching = false
        filteredArticles.removeAll()
    }
}

