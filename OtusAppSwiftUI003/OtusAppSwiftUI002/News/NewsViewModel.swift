//
//  NewsViewModel.swift
//  OtusAppSwiftUI002
//
//  Created by Aleksandra Navruzova on 03/04/2023.
//

import Foundation
import Core

final class NewsViewModel: ObservableObject {
    @Published var articles: [Article] = .init()
    @Injected var service: NewsServiceProtocol?
    private var userDefaults: UserDefaultsModel = .init()
    
    init() {
        getNews(section: .world)
    }
    
    func getNews(section: NewsSections) {
        if let articles = userDefaults.getCachedArticles(section: section) {
            self.articles = articles
            return
        }
        
        fetchNews(section: section)
    }
    
    func fetchNews(section: NewsSections) {
        service?.getNews(section: section, completion: { result in
            switch result {
            case .success(let articles):
                self.articles = articles
                self.userDefaults.casheData(for: articles, section: section)
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func refreshNews(section: NewsSections) {
        fetchNews(section: section)
    }
}
