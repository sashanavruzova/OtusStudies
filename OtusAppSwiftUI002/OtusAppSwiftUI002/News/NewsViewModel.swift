//
//  NewsViewModel.swift
//  OtusAppSwiftUI002
//
//  Created by Александра Наврузова on 03/04/2023.
//

import Foundation
import Networking

final class NewsViewModel: ObservableObject {
    @Published var articles: [Article] = .init()
    
    init() {
        getNews(section: .world)
    }
    
    func getNews(section: NewsSections) {
        let section = returnQuery(section: section)
        ArticlesAPI.everythingGet(q: section,
                                  from: "2023-02-29",
                                  sortBy: "publishedAt",
                                  language: "en",
                                  apiKey: "2ed2c11a2fa04b55b14fff672b7e175f") { data, error in
            debugPrint(error ?? "")
            self.articles = data?.articles ?? []
        }
    }
    
    func returnQuery(section: NewsSections) -> String {
        switch section {
        case .world:
            return "World"
        case .israel:
            return "Israel"
        case .russia:
            return "Russia"
        }
    }

}
