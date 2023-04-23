//
//  NewsService.swift
//  OtusAppSwiftUI002
//
//  Created by Aleksandra Navruzova on 14/04/2023.
//

import Foundation
import Networking

public protocol NewsServiceProtocol {
    func getNews(section: NewsSections, completion: @escaping (Result<[Article], Error>) -> Void)
}

final public class NewsService: NewsServiceProtocol {
    
    public func getNews(section: NewsSections, completion: @escaping (Result<[Article], Error>) -> Void) {
        let sectionQuery = returnQuery(section: section)
        ArticlesAPI.everythingGet(q: sectionQuery,
                                  from: "2023-02-29",
                                  sortBy: "publishedAt",
                                  language: "en",
                                  apiKey: "2ed2c11a2fa04b55b14fff672b7e175f") { data, error in
            if let error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data.articles ?? []))
            } else {
                completion(.failure(NSError(domain: "Error", code: 0)))
            }
        }
    }
    
    public func returnQuery(section: NewsSections) -> String {
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
