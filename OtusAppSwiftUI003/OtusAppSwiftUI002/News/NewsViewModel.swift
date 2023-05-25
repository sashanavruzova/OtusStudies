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
    
    init() {
        getNews(section: .world)
    }
    
    func getNews(section: NewsSections) {
        service?.getNews(section: section, completion: { result in
            switch result {
            case .success(let articles):
                self.articles = articles
            case .failure(let error):
                print(error)
            }
        })
    }
}
