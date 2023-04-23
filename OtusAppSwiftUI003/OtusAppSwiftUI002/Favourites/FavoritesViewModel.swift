//
//  FavoritesViewModel.swift
//  OtusAppSwiftUI002
//
//  Created by Aleksandra Navruzova on 09/04/2023.
//

import Foundation
import Networking

class FavoritesViewModel: ObservableObject {
    @Published var favoritesArticles = [Article]()
    
    func addFavorites(article: Article) {
        favoritesArticles.append(article)
    }
    
    func removeFavorites(article: Article) {
        if let index = favoritesArticles.firstIndex(where: { $0.title == article.title }) {
            favoritesArticles.remove(at: index)
        }
    }
}
