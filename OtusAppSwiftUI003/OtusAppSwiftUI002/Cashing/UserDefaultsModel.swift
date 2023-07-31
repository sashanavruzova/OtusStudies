//
//  UserDefaults
//  UserDefaultsModel.swift
//  OtusAppSwiftUI002
//
//  Created by Sasha Navruzov on 31/07/2023.
//

import SwiftUI
import Core

final class UserDefaultsModel: ObservableObject {
    private var defaults = UserDefaults.standard
    
    struct CachedData: Codable {
        let data: [Article]
    }
    
    private var articleForFile = [String: Any]()
    
    func casheData(for articles: [Article], section: NewsSections) {
        guard let dataArticles = convertArticleToJSON(articles) else { return }
        defaults.set(dataArticles, forKey: getKey(section: section))
    }
    
    func getCachedArticles(section: NewsSections) -> [Article]? {
        guard let data = UserDefaults.standard.object(forKey: getKey(section: section)) as? Data else { return nil }
        do {
            let cached = try JSONDecoder().decode(CachedData.self, from: data)
            return cached.data
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    fileprivate func getKey(section: NewsSections) -> String {
        "laureates_in_\(section)"
    }
    
    fileprivate func convertArticleToJSON(_ articles: [Article]) -> Data? {
        do {
            let encodedData = try JSONEncoder().encode(CachedData(data: articles))
            return encodedData
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

